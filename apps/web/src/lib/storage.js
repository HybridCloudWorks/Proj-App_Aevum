/**
 * Firebase Storage service for Aevum media.
 *
 * PR-01 keeps the existing storage paths for compatibility. Canonical storage
 * paths and security rules are changed together in the follow-up security PR.
 */

import {
  deleteObject,
  getDownloadURL,
  listAll,
  ref,
  uploadBytesResumable,
} from "firebase/storage";
import { storage } from "./firebase";
import { createThumbnail, extractImageMetadata } from "./imageMetadata";

const MAX_CACHE_SIZE = 500;
const downloadUrlCache = new Map();

function cacheKey(storageRef) {
  return storageRef?.fullPath || storageRef?._path || storageRef?.name || null;
}

function evictDownloadUrl(storageRefOrPath) {
  const key =
    typeof storageRefOrPath === "string"
      ? storageRefOrPath
      : cacheKey(storageRefOrPath);
  if (key) downloadUrlCache.delete(key);
}

async function getCachedDownloadURL(storageRef) {
  const key = cacheKey(storageRef);
  if (!key) return getDownloadURL(storageRef);

  if (!downloadUrlCache.has(key)) {
    if (downloadUrlCache.size >= MAX_CACHE_SIZE) {
      const oldestKey = downloadUrlCache.keys().next().value;
      if (oldestKey) downloadUrlCache.delete(oldestKey);
    }

    const promise = getDownloadURL(storageRef).catch((error) => {
      downloadUrlCache.delete(key);
      throw error;
    });
    downloadUrlCache.set(key, promise);
  }

  return downloadUrlCache.get(key);
}

function waitForUpload(uploadTask, onProgress = () => {}, progressWeight = 1) {
  return new Promise((resolve, reject) => {
    uploadTask.on(
      "state_changed",
      (snapshot) => {
        if (!snapshot.totalBytes) return;
        const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        onProgress(progress * progressWeight);
      },
      reject,
      () => resolve(uploadTask.snapshot),
    );
  });
}

export async function uploadPhoto(
  file,
  familyId,
  userId,
  onProgress = () => {},
  options = { extractMetadata: true, createThumbnail: true },
) {
  try {
    const timestamp = Date.now();
    const safeName = file.name.replace(/[^a-zA-Z0-9.-]/g, "_");
    const path = `families/${familyId}/memories/${timestamp}_${safeName}`;
    const storageRef = ref(storage, path);

    let imageMetadata = null;
    if (options.extractMetadata) {
      try {
        imageMetadata = await extractImageMetadata(file);
      } catch (error) {
        console.warn("Metadata extraction failed:", error);
      }
    }

    const customMetadata = {
      uploadedBy: userId,
      originalName: file.name,
      uploadedAt: new Date().toISOString(),
      ...(imageMetadata && {
        width: String(imageMetadata.width || ""),
        height: String(imageMetadata.height || ""),
        aspectRatio: String(imageMetadata.aspectRatio || ""),
        dateTaken: imageMetadata.exif?.dateTaken || "",
        camera: imageMetadata.exif?.camera || "",
        hasGps: String(Boolean(imageMetadata.gps?.latitude)),
      }),
    };

    const mainTask = uploadBytesResumable(storageRef, file, {
      contentType: file.type,
      customMetadata,
    });

    const progressWeight = options.createThumbnail ? 0.8 : 1;
    let mainSnapshot;
    try {
      mainSnapshot = await waitForUpload(mainTask, onProgress, progressWeight);
    } catch (error) {
      console.error("Upload error:", error);
      return {
        success: false,
        error: getStorageErrorMessage(error.code),
      };
    }

    const uploadedRef = mainSnapshot?.ref || mainTask.snapshot?.ref || storageRef;
    evictDownloadUrl(uploadedRef);
    const url = await getCachedDownloadURL(uploadedRef);

    let thumbnailUrl = null;
    if (options.createThumbnail) {
      try {
        const thumbnail = await createThumbnail(
          file,
          200,
          imageMetadata
            ? { width: imageMetadata.width, height: imageMetadata.height }
            : null,
        );

        if (thumbnail) {
          const thumbnailPath = `families/${familyId}/thumbnails/${timestamp}_${safeName}`;
          const thumbnailRef = ref(storage, thumbnailPath);
          const thumbnailTask = uploadBytesResumable(thumbnailRef, thumbnail, {
            contentType: "image/jpeg",
          });
          const thumbnailSnapshot = await thumbnailTask;
          const uploadedThumbnailRef = thumbnailSnapshot?.ref || thumbnailRef;
          evictDownloadUrl(uploadedThumbnailRef);
          thumbnailUrl = await getCachedDownloadURL(uploadedThumbnailRef);
        }
      } catch (error) {
        console.warn("Thumbnail creation failed:", error);
      }
    }

    onProgress(100);
    return {
      success: true,
      url,
      path,
      thumbnailUrl,
      metadata: imageMetadata,
    };
  } catch (error) {
    console.error("Upload photo error:", error);
    return { success: false, error: error.message };
  }
}

export async function uploadMultiplePhotos(
  files,
  familyId,
  userId,
  onProgress = () => {},
) {
  const fileArray = Array.from(files || []);
  if (!fileArray.length) {
    return { success: true, results: [], failed: [] };
  }

  const progressByFile = new Array(fileArray.length).fill(0);
  let totalProgress = 0;

  const uploadResults = await Promise.all(
    fileArray.map(async (file, index) => {
      const result = await uploadPhoto(file, familyId, userId, (progress) => {
        totalProgress -= progressByFile[index];
        progressByFile[index] = progress;
        totalProgress += progress;
        onProgress(totalProgress / fileArray.length);
      });

      return { file: file.name, ...result };
    }),
  );

  const results = uploadResults.filter((result) => result.success);
  const failed = uploadResults
    .filter((result) => !result.success)
    .map((result) => ({ file: result.file, error: result.error }));

  onProgress(100);
  return { success: failed.length === 0, results, failed };
}

export async function getPhotoURL(path) {
  try {
    const storageRef = ref(storage, path);
    return { success: true, url: await getCachedDownloadURL(storageRef) };
  } catch (error) {
    console.error("Get photo URL error:", error);
    return { success: false, error: getStorageErrorMessage(error.code) };
  }
}

export async function deletePhoto(path) {
  try {
    const storageRef = ref(storage, path);
    await deleteObject(storageRef);
    evictDownloadUrl(storageRef);
    evictDownloadUrl(path);
    return { success: true };
  } catch (error) {
    console.error("Delete photo error:", error);
    return { success: false, error: getStorageErrorMessage(error.code) };
  }
}

export async function listFamilyPhotos(familyId) {
  try {
    const result = await listAll(ref(storage, `families/${familyId}/memories`));
    return {
      success: true,
      photos: result.items.map((itemRef) => ({
        name: itemRef.name,
        path: itemRef.fullPath,
      })),
    };
  } catch (error) {
    console.error("List photos error:", error);
    return { success: false, error: getStorageErrorMessage(error.code) };
  }
}

async function uploadSimplePhoto(file, path) {
  const storageRef = ref(storage, path);
  const snapshot = await uploadBytesResumable(storageRef, file, {
    contentType: file.type,
  });
  const uploadedRef = snapshot?.ref || storageRef;
  evictDownloadUrl(uploadedRef);
  return {
    success: true,
    url: await getCachedDownloadURL(uploadedRef),
    path,
  };
}

export async function uploadProfilePhoto(file, userId) {
  try {
    const extension = file.name.split(".").pop();
    return await uploadSimplePhoto(file, `users/${userId}/profile.${extension}`);
  } catch (error) {
    console.error("Upload profile photo error:", error);
    return { success: false, error: error.message };
  }
}

export async function uploadMemberPhoto(file, familyId, memberId) {
  try {
    const extension = file.name.split(".").pop();
    return await uploadSimplePhoto(
      file,
      `families/${familyId}/members/${memberId}/photo.${extension}`,
    );
  } catch (error) {
    console.error("Upload member photo error:", error);
    return { success: false, error: error.message };
  }
}

function getStorageErrorMessage(code) {
  const messages = {
    "storage/unauthorized": "You do not have permission to upload files.",
    "storage/canceled": "Upload was canceled.",
    "storage/unknown": "An unknown error occurred.",
    "storage/object-not-found": "File not found.",
    "storage/bucket-not-found": "Storage bucket not found.",
    "storage/project-not-found": "Project not found.",
    "storage/quota-exceeded": "Storage quota exceeded.",
    "storage/unauthenticated": "Please sign in to upload files.",
    "storage/invalid-checksum":
      "File was corrupted during upload. Please try again.",
    "storage/retry-limit-exceeded":
      "Upload failed after multiple attempts. Please try again.",
  };
  return messages[code] || "An error occurred during upload.";
}

export function validateFile(file, options = {}) {
  const {
    maxSizeMB = 10,
    allowedTypes = ["image/jpeg", "image/png", "image/webp", "image/heic"],
  } = options;

  if (!file) return { valid: false, error: "No file provided." };

  if (!allowedTypes.includes(file.type)) {
    return {
      valid: false,
      error:
        "File type not supported. Please upload a JPEG, PNG, WebP, or HEIC image.",
    };
  }

  if (file.size / (1024 * 1024) > maxSizeMB) {
    return { valid: false, error: `File size exceeds ${maxSizeMB}MB limit.` };
  }

  return { valid: true };
}
