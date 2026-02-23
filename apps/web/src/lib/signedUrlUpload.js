import { getFunctions, httpsCallable } from "firebase/functions";
import { app } from "./firebase"; // Adjust import path as needed

const functions = getFunctions(app, "us-central1");

/**
 * Requests a signed URL for secure direct upload to Google Cloud Storage.
 *
 * @param {string} userId - The ID of the uploading user.
 * @param {string} familyId - The ID of the family context.
 * @param {string} contentType - The MIME type of the file (e.g., 'image/jpeg').
 * @returns {Promise<{url: string, path: string, fileId: string}>}
 */
export async function getSignedUploadUrl(userId, familyId, contentType) {
  try {
    const generateUploadUrl = httpsCallable(functions, "generateUploadUrl");
    const result = await generateUploadUrl({
      userId,
      familyId,
      contentType,
    });
    return result.data;
  } catch (error) {
    console.error("Error getting signed URL:", error);
    throw new Error("Failed to initiate secure upload.");
  }
}

/**
 * Uploads a file directly to the signed URL via PUT request.
 *
 * @param {string} url - The signed URL provided by the backend.
 * @param {File} file - The file object to upload.
 * @param {string} contentType - The MIME type of the file.
 * @param {Function} onProgress - Optional callback for upload progress (0-100).
 * @returns {Promise<void>}
 */
export async function uploadToSignedUrl(
  url,
  file,
  contentType,
  onProgress = () => {},
) {
  return new Promise((resolve, reject) => {
    const xhr = new XMLHttpRequest();

    xhr.open("PUT", url, true);
    xhr.setRequestHeader("Content-Type", contentType);

    // Track upload progress
    xhr.upload.onprogress = (event) => {
      if (event.lengthComputable) {
        const percentComplete = (event.loaded / event.total) * 100;
        onProgress(percentComplete);
      }
    };

    xhr.onload = () => {
      if (xhr.status >= 200 && xhr.status < 300) {
        resolve();
      } else {
        reject(new Error(`Upload failed with status: ${xhr.status}`));
      }
    };

    xhr.onerror = () => reject(new Error("Network error during upload."));

    xhr.send(file);
  });
}
