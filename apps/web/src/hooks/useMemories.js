/**
 * useMemories Hook
 *
 * Coordinates Firebase Storage uploads with Firestore media records while
 * preserving the existing memories API used by the current screens.
 */

import { useCallback, useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import {
  batchCreateMemories,
  createMemory,
  deleteMemory,
  subscribeToMediaItems,
  updateMemory,
} from "@lib/firestore";
import {
  deletePhoto,
  uploadMultiplePhotos,
  uploadPhoto,
  validateFile,
} from "@lib/storage";

function mediaRecordFromUpload(result, userId, metadata = {}) {
  const capturedAt =
    metadata.date ||
    result.metadata?.exif?.dateTaken ||
    new Date().toISOString();

  return {
    userId,
    uploadedBy: userId,
    title: metadata.title || result.file || "Untitled memory",
    description: metadata.description || "",
    imageUrl: result.url,
    photoUrl: result.url,
    thumbnailUrl: result.thumbnailUrl || result.url,
    storagePath: result.path,
    date: capturedAt,
    tags: metadata.tags || [],
    memberIds: metadata.memberIds || [],
    imageMetadata: result.metadata
      ? {
          width: result.metadata.width,
          height: result.metadata.height,
          aspectRatio: result.metadata.aspectRatio,
          fileSize: result.metadata.fileSize,
          exif: result.metadata.exif || {},
          gps: result.metadata.gps || {},
        }
      : null,
  };
}

export function useMemories(familyId) {
  const { user } = useAuth();
  const userId = user?.uid;

  const [memories, setMemories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [uploading, setUploading] = useState(false);
  const [uploadProgress, setUploadProgress] = useState(0);
  const [error, setError] = useState(null);

  useEffect(() => {
    if (!familyId) {
      setMemories([]);
      setLoading(false);
      return undefined;
    }

    setLoading(true);
    setError(null);
    const unsubscribe = subscribeToMediaItems(
      familyId,
      (data) => {
        setMemories(data);
        setLoading(false);
      },
      20,
      (subscriptionError) => {
        setError(subscriptionError.message);
        setLoading(false);
      },
    );

    return unsubscribe;
  }, [familyId]);

  const uploadMemory = useCallback(
    async (file, metadata = {}) => {
      if (!userId || !familyId) {
        return {
          success: false,
          error: "Not authenticated or no family selected",
        };
      }

      const validation = validateFile(file);
      if (!validation.valid) return validation;

      setError(null);
      setUploading(true);
      setUploadProgress(0);

      let uploadedPath = null;
      try {
        const uploadResult = await uploadPhoto(
          file,
          familyId,
          userId,
          setUploadProgress,
          { extractMetadata: true, createThumbnail: true },
        );

        if (!uploadResult.success) {
          setError(uploadResult.error);
          return uploadResult;
        }

        uploadedPath = uploadResult.path;
        const memoryResult = await createMemory(
          familyId,
          mediaRecordFromUpload(
            { ...uploadResult, file: file.name },
            userId,
            metadata,
          ),
        );

        if (!memoryResult.success) {
          setError(memoryResult.error);
          if (uploadedPath) await deletePhoto(uploadedPath);
          return memoryResult;
        }

        return {
          success: true,
          memoryId: memoryResult.id,
          photoUrl: uploadResult.url,
          thumbnailUrl: uploadResult.thumbnailUrl,
          metadata: uploadResult.metadata,
        };
      } catch (uploadError) {
        setError(uploadError.message);
        if (uploadedPath) await deletePhoto(uploadedPath);
        return { success: false, error: uploadError.message };
      } finally {
        setUploading(false);
        setUploadProgress(0);
      }
    },
    [familyId, userId],
  );

  const uploadMultipleMemories = useCallback(
    async (files, metadata = {}) => {
      if (!userId || !familyId) {
        return {
          success: false,
          error: "Not authenticated or no family selected",
        };
      }

      const fileArray = Array.from(files || []);
      if (!fileArray.length) {
        return { success: true, uploaded: 0, failed: [] };
      }

      const invalidFile = fileArray
        .map((file) => ({ file, validation: validateFile(file) }))
        .find(({ validation }) => !validation.valid);
      if (invalidFile) {
        return {
          success: false,
          uploaded: 0,
          failed: [{ file: invalidFile.file.name, error: invalidFile.validation.error }],
          error: invalidFile.validation.error,
        };
      }

      setError(null);
      setUploading(true);
      setUploadProgress(0);

      try {
        const uploadResult = await uploadMultiplePhotos(
          fileArray,
          familyId,
          userId,
          setUploadProgress,
        );

        if (!uploadResult.results.length) {
          const firstError = uploadResult.failed[0]?.error || "No files were uploaded";
          setError(firstError);
          return {
            success: false,
            uploaded: 0,
            failed: uploadResult.failed,
            error: firstError,
          };
        }

        const records = uploadResult.results.map((result) =>
          mediaRecordFromUpload(result, userId, metadata),
        );
        const memoryResult = await batchCreateMemories(familyId, records);

        if (!memoryResult.success) {
          setError(memoryResult.error);
          await Promise.allSettled(
            uploadResult.results
              .map((result) => result.path)
              .filter(Boolean)
              .map((path) => deletePhoto(path)),
          );
        }

        return {
          success: uploadResult.failed.length === 0 && memoryResult.success,
          uploaded: memoryResult.success ? uploadResult.results.length : 0,
          failed: uploadResult.failed,
          error: memoryResult.error,
        };
      } catch (uploadError) {
        setError(uploadError.message);
        return { success: false, uploaded: 0, failed: [], error: uploadError.message };
      } finally {
        setUploading(false);
        setUploadProgress(0);
      }
    },
    [familyId, userId],
  );

  const editMemory = useCallback(
    async (memoryId, updates) => {
      if (!familyId) return { success: false, error: "No family selected" };
      setError(null);
      const result = await updateMemory(familyId, memoryId, updates);
      if (!result.success) setError(result.error);
      return result;
    },
    [familyId],
  );

  const removeMemory = useCallback(
    async (memoryId, storagePath) => {
      if (!familyId) return { success: false, error: "No family selected" };

      setError(null);
      const result = await deleteMemory(familyId, memoryId);
      if (!result.success) {
        setError(result.error);
        return result;
      }

      if (storagePath) {
        const storageResult = await deletePhoto(storagePath);
        if (!storageResult.success) {
          setError(storageResult.error);
          return {
            success: false,
            error: storageResult.error,
            firestoreDeleted: true,
          };
        }
      }

      return result;
    },
    [familyId],
  );

  return {
    memories,
    loading,
    uploading,
    uploadProgress,
    error,
    uploadMemory,
    uploadMultipleMemories,
    editMemory,
    removeMemory,
  };
}

export default useMemories;
