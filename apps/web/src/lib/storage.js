/**
 * Firebase Storage Service
 *
 * Handles photo uploads, downloads, and management for family memories.
 * Integrates with imageMetadata for EXIF extraction and thumbnail generation.
 */

import {
  ref,
  uploadBytesResumable,
  getDownloadURL,
  deleteObject,
  listAll,
} from "firebase/storage";
import { storage } from "./firebase";
import { extractImageMetadata, createThumbnail } from "./imageMetadata";

// Cache for getDownloadURL promises to deduplicate concurrent requests and avoid N+1 network calls
// Max size of 500 to prevent unbounded memory growth, evicting oldest (FIFO)
const MAX_CACHE_SIZE = 500;
const downloadUrlCache = new Map();

/**
 * Helper to get cached download URL promise
 * @param {import("firebase/storage").StorageReference} storageRef
 */
const getCachedDownloadURL = (storageRef) => {
  const path = storageRef.fullPath;
  if (!downloadUrlCache.has(path)) {
    // Cache the promise itself to deduplicate concurrent requests
    const promise = getDownloadURL(storageRef).catch((error) => {
      downloadUrlCache.delete(path);
      throw error;
    });
    downloadUrlCache.set(path, promise);
    if (downloadUrlCache.size > MAX_CACHE_SIZE) {
      const firstKey = downloadUrlCache.keys().next().value;
      downloadUrlCache.delete(firstKey);
    }
  }
  return downloadUrlCache.get(path);
};
// In-memory cache for download URLs to avoid redundant N+1 getDownloadURL calls.
// Using a Map for O(1) lookups.
const downloadUrlCache = new Map();
const MAX_CACHE_SIZE = 500;

/**
 * Upload a photo to Firebase Storage with progress tracking and metadata extraction
 * @param {File} file - The file to upload
 * @param {string} familyId - The family ID to organize under
 * @param {string} userId - The user ID who uploaded
 * @param {Function} onProgress - Progress callback (0-100)
 * @param {Object} options - Additional options
 * @returns {Promise<{success: boolean, url?: string, path?: string, metadata?: Object, thumbnailUrl?: string, error?: string}>}
 */
export async function uploadPhoto(
  file,
  familyId,
  userId,
  onProgress = () => {},
  options = { extractMetadata: true, createThumbnail: true },
) {
  try {
    // Create unique filename with timestamp
    const timestamp = Date.now();
    const safeName = file.name.replace(/[^a-zA-Z0-9.-]/g, "_");
    const path = `families/${familyId}/memories/${timestamp}_${safeName}`;
    const storageRef = ref(storage, path);

    // Extract metadata in parallel with preparing upload
    let imageMetadata = null;
    let thumbnailUrl = null;

    if (options.extractMetadata) {
      try {
        imageMetadata = await extractImageMetadata(file);
      } catch (e) {
        console.warn("Metadata extraction failed:", e);
      }
    }

    // Create upload task with enhanced metadata
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
        hasGps: String(!!imageMetadata.gps?.latitude),
      }),
    };

    const uploadTask = uploadBytesResumable(storageRef, file, {
      contentType: file.type,
      customMetadata,
    });

    // Optimization: Run main upload and thumbnail creation/upload in parallel
    const mainUploadPromise = new Promise((resolve) => {
      uploadTask.on(
        "state_changed",
        (snapshot) => {
          const progress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          onProgress(progress * 0.8); // Reserve 20% for thumbnail
        },
        (error) => {
          console.error("Upload error:", error);
          resolve({
            success: false,
            error: getStorageErrorMessage(error.code),
          });
        },
        async () => {
          if (downloadUrlCache.has(uploadTask.snapshot.ref.fullPath)) {
            downloadUrlCache.delete(uploadTask.snapshot.ref.fullPath);
          }
          const url = await getCachedDownloadURL(uploadTask.snapshot.ref);
          resolve({ success: true, url, path });
        },
      );
    });

    // Handle thumbnail creation and upload promise
    const thumbnailPromise = (async () => {
      if (!options.createThumbnail) return null;

      try {
        // Optimization: Pass extracted dimensions if available to skip re-reading them
        const thumbBlob = await createThumbnail(
          file,
          200,
          imageMetadata
            ? { width: imageMetadata.width, height: imageMetadata.height }
            : null,
        );
        const thumbPath = `families/${familyId}/thumbnails/${timestamp}_${safeName}`;
        const thumbRef = ref(storage, thumbPath);

        await uploadBytesResumable(thumbRef, thumbBlob, {
          contentType: "image/jpeg",
        });

        if (downloadUrlCache.has(thumbRef.fullPath)) {
          downloadUrlCache.delete(thumbRef.fullPath);
        }
        return await getCachedDownloadURL(thumbRef);
      } catch (e) {
        console.warn("Thumbnail creation failed:", e);
        return null;
      }
    })();

    // Wait for both operations to complete
    const [mainResult, thumbUrl] = await Promise.all([
      mainUploadPromise,
      thumbnailPromise,
    ]);

    if (!mainResult.success) {
      return mainResult;
    }

    if (thumbUrl) {
      thumbnailUrl = thumbUrl;
    }

    // Ensure 100% progress when everything is done
    onProgress(100);

    return {
      success: true,
      url: mainResult.url,
      path: mainResult.path,
      thumbnailUrl,
      metadata: imageMetadata,
    };
  } catch (error) {
    console.error("Upload photo error:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Upload multiple photos with combined progress tracking
 * @param {File[]} files - Array of files to upload
 * @param {string} familyId - The family ID
 * @param {string} userId - The user ID
 * @param {Function} onProgress - Progress callback for overall progress
 * @returns {Promise<{success: boolean, results: Array, failed: Array}>}
 */
export async function uploadMultiplePhotos(
  files,
  familyId,
  userId,
  onProgress = () => {},
) {
  const results = [];
  const failed = [];

  if (!files || files.length === 0) {
    return { success: true, results, failed };
  }

  // Track individual progress for each file
  const fileArray = Array.from(files);
  const progressArray = new Array(fileArray.length).fill(0);
  let totalProgressSum = 0;

  // Optimization: Use an incremental running sum instead of calling .reduce() on every progress event.
  // This changes the overall progress calculation from O(N) to O(1) per event.
  let runningTotalProgress = 0;

  const uploadPromises = fileArray.map(async (file, index) => {
    const result = await uploadPhoto(file, familyId, userId, (progress) => {
      const oldProgress = progressArray[index];
      runningTotalProgress = runningTotalProgress - oldProgress + progress;
      progressArray[index] = progress;

      // Calculate overall progress as the average of all individual progresses
      const overallProgress = runningTotalProgress / fileArray.length;
      // Optimization: Update total progress incrementally instead of using .reduce()
      // which is O(N) on every progress event. This makes the update O(1).

  // Optimization: Track total sum incrementally (O(1)) instead of using .reduce() (O(N)) on every progress event
  let totalProgressSum = 0;

  const uploadPromises = fileArray.map(async (file, index) => {
    const result = await uploadPhoto(file, familyId, userId, (progress) => {
      // Optimization: Update totalProgressSum incrementally instead of using .reduce()
      // This reduces complexity from O(N) to O(1) per progress event
      totalProgressSum -= progressArray[index];
      progressArray[index] = progress;
      totalProgressSum += progressArray[index];

      const overallProgress = totalProgressSum / fileArray.length;
      // O(1) incremental update of the total sum
      totalProgressSum = totalProgressSum - progressArray[index] + progress;
      progressArray[index] = progress;

      const overallProgress = totalProgressSum / files.length;
      onProgress(overallProgress);
    });

    return { file: file.name, ...result };
  });

  const uploadResults = await Promise.all(uploadPromises);

  for (const result of uploadResults) {
    if (result.success) {
      // The result already contains `file: file.name` from the map above
      results.push(result);
    } else {
      failed.push({ file: result.file, error: result.error });
    }
  }

  return {
    success: failed.length === 0,
    results,
    failed,
  };
}

/**
 * Get the download URL for a file path
 * @param {string} path - The storage path
 * @returns {Promise<{success: boolean, url?: string, error?: string}>}
 */
export async function getPhotoURL(path) {
  try {
    const storageRef = ref(storage, path);
    const url = await getCachedDownloadURL(storageRef);
    return { success: true, url };
  } catch (error) {
    console.error("Get photo URL error:", error);
    return { success: false, error: getStorageErrorMessage(error.code) };
  }
}

/**
 * Delete a photo from storage
 * @param {string} path - The storage path
 * @returns {Promise<{success: boolean, error?: string}>}
 */
export async function deletePhoto(path) {
  try {
    const storageRef = ref(storage, path);
    await deleteObject(storageRef);
    if (downloadUrlCache.has(storageRef.fullPath)) {
      downloadUrlCache.delete(storageRef.fullPath);
    // Evict from cache if deleted
    if (downloadUrlCache.has(path)) {
      downloadUrlCache.delete(path);
    }
    return { success: true };
  } catch (error) {
    console.error("Delete photo error:", error);
    return { success: false, error: getStorageErrorMessage(error.code) };
  }
}

// Optimization: In-memory cache for download URLs to deduplicate concurrent requests
// and eliminate N+1 API call pattern. Uses a fixed size limit with FIFO eviction.
const downloadUrlCache = new Map();
const MAX_CACHE_SIZE = 500;

async function getCachedDownloadURL(itemRef) {
  const path = itemRef.fullPath;
  if (downloadUrlCache.has(path)) {
    return downloadUrlCache.get(path);
  }

  const urlPromise = getDownloadURL(itemRef).catch((error) => {
    downloadUrlCache.delete(path);
    throw error;
  });

  if (downloadUrlCache.size >= MAX_CACHE_SIZE) {
    const firstKey = downloadUrlCache.keys().next().value;
    downloadUrlCache.delete(firstKey);
  }

  downloadUrlCache.set(path, urlPromise);
  return urlPromise;
}

/**
 * List all photos in a family's memories folder
 * @param {string} familyId - The family ID
 * @returns {Promise<{success: boolean, photos?: Array, error?: string}>}
 */
export async function listFamilyPhotos(familyId) {
  try {
    const listRef = ref(storage, `families/${familyId}/memories`);
    const result = await listAll(listRef);

    // ⚡ Bolt Optimization: Return metadata only and skip pre-fetching download URLs.
    // This avoids N+1 network requests (getDownloadURL). Callers should fetch
    // URLs lazily using getPhotoURL(path) when needed for display.
    const photos = result.items.map((itemRef) => ({
      name: itemRef.name,
      path: itemRef.fullPath,
    }));
    const photos = await Promise.all(
      result.items.map(async (itemRef) => {
        const url = await getCachedDownloadURL(itemRef);
        // Optimization: Use cached getDownloadURL to avoid N+1 API calls
        const url = await getCachedDownloadURL(itemRef);
        const cacheKey = itemRef.fullPath;

        // Optimization: Cache the Promise instead of the resolved value to
        // deduplicate concurrent requests for the same URL.
        let urlPromise = downloadUrlCache.get(cacheKey);

        if (!urlPromise) {
          // Simple cache eviction: clear if it grows too large
          if (downloadUrlCache.size >= MAX_CACHE_SIZE) {
            downloadUrlCache.clear();
          }

          urlPromise = getDownloadURL(itemRef);
          downloadUrlCache.set(cacheKey, urlPromise);
        }

        const url = await urlPromise;

        return {
          name: itemRef.name,
          path: itemRef.fullPath,
          url,
        };
      }),
    );

    return { success: true, photos };
  } catch (error) {
    console.error("List photos error:", error);
    return { success: false, error: getStorageErrorMessage(error.code) };
  }
}

/**
 * Upload a profile photo for a user
 * @param {File} file - The profile image file
 * @param {string} userId - The user ID
 * @returns {Promise<{success: boolean, url?: string, path?: string, error?: string}>}
 */
export async function uploadProfilePhoto(file, userId) {
  try {
    const path = `users/${userId}/profile.${file.name.split(".").pop()}`;
    const storageRef = ref(storage, path);

    await uploadBytesResumable(storageRef, file, {
      contentType: file.type,
    });

    if (downloadUrlCache.has(storageRef.fullPath)) {
      downloadUrlCache.delete(storageRef.fullPath);
    }
    const url = await getCachedDownloadURL(storageRef);
    return { success: true, url, path };
  } catch (error) {
    console.error("Upload profile photo error:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Upload a photo for a family member
 * @param {File} file - The member photo file
 * @param {string} familyId - The family ID
 * @param {string} memberId - The member ID
 * @returns {Promise<{success: boolean, url?: string, path?: string, error?: string}>}
 */
export async function uploadMemberPhoto(file, familyId, memberId) {
  try {
    const path = `families/${familyId}/members/${memberId}/photo.${file.name.split(".").pop()}`;
    const storageRef = ref(storage, path);

    await uploadBytesResumable(storageRef, file, {
      contentType: file.type,
    });

    if (downloadUrlCache.has(storageRef.fullPath)) {
      downloadUrlCache.delete(storageRef.fullPath);
    }
    const url = await getCachedDownloadURL(storageRef);
    return { success: true, url, path };
  } catch (error) {
    console.error("Upload member photo error:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Get user-friendly error messages for storage errors
 */
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

/**
 * Validate file before upload
 * @param {File} file - The file to validate
 * @param {Object} options - Validation options
 * @returns {{valid: boolean, error?: string}}
 */
export function validateFile(file, options = {}) {
  const {
    maxSizeMB = 10,
    allowedTypes = ["image/jpeg", "image/png", "image/webp", "image/heic"],
  } = options;

  if (!file) {
    return { valid: false, error: "No file provided." };
  }

  if (!allowedTypes.includes(file.type)) {
    return {
      valid: false,
      error:
        "File type not supported. Please upload a JPEG, PNG, or WebP image.",
    };
  }

  const sizeMB = file.size / (1024 * 1024);
  if (sizeMB > maxSizeMB) {
    return { valid: false, error: `File size exceeds ${maxSizeMB}MB limit.` };
  }

  return { valid: true };
}
