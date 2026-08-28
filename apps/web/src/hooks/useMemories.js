/**
 * useMemories Hook
 *
 * Canonical upload lifecycle:
 * reserve Firestore media ID -> upload original -> finalize upload metadata ->
 * backend preservation processor creates derivatives/archive and advances status.
 */

import { useCallback, useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import {
  deleteMemory,
  finalizeMediaUpload,
  markMediaUploadFailed,
  reserveMediaItem,
  subscribeToMediaItems,
  updateMemory,
} from "@lib/firestore";
import {
  deletePhoto,
  uploadMultiplePhotos,
  uploadPhoto,
  validateFile,
} from "@lib/storage";

function reservationData(file, metadata = {}) {
  return {
    title: metadata.title || file.name || "Untitled memory",
    description: metadata.description || "",
    date: metadata.date || new Date().toISOString(),
    tags: metadata.tags || [],
    memberIds: metadata.memberIds || [],
    originalFileName: file.name,
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

      let mediaId = null;
      let uploadedPath = null;

      try {
        const reservation = await reserveMediaItem(
          familyId,
          userId,
          reservationData(file, metadata),
        );
        if (!reservation.success) {
          setError(reservation.error);
          return reservation;
        }

        mediaId = reservation.mediaId;
        const uploadResult = await uploadPhoto(
          file,
          familyId,
          userId,
          setUploadProgress,
          {
            mediaId,
            extractMetadata: true,
            createThumbnail: false,
          },
        );

        if (!uploadResult.success) {
          await markMediaUploadFailed(mediaId, uploadResult.error);
          setError(uploadResult.error);
          return { ...uploadResult, memoryId: mediaId };
        }

        uploadedPath = uploadResult.path;
        const finalization = await finalizeMediaUpload(mediaId, uploadResult);
        if (!finalization.success) {
          if (uploadedPath) await deletePhoto(uploadedPath);
          await markMediaUploadFailed(mediaId, finalization.error);
          setError(finalization.error);
          return { ...finalization, memoryId: mediaId };
        }

        return {
          success: true,
          memoryId: mediaId,
          mediaId,
          photoUrl: uploadResult.url,
          thumbnailUrl: uploadResult.thumbnailUrl || uploadResult.url,
          metadata: uploadResult.metadata,
          status: "uploaded",
        };
      } catch (uploadError) {
        if (uploadedPath) await deletePhoto(uploadedPath);
        if (mediaId) await markMediaUploadFailed(mediaId, uploadError.message);
        setError(uploadError.message);
        return { success: false, memoryId: mediaId, error: uploadError.message };
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
          failed: [
            {
              file: invalidFile.file.name,
              error: invalidFile.validation.error,
            },
          ],
          error: invalidFile.validation.error,
        };
      }

      setError(null);
      setUploading(true);
      setUploadProgress(0);

      try {
        const reservations = await Promise.all(
          fileArray.map((file) =>
            reserveMediaItem(
              familyId,
              userId,
              reservationData(file, metadata),
            ),
          ),
        );

        const failed = [];
        const uploadFiles = [];
        const mediaIds = [];

        reservations.forEach((reservation, index) => {
          if (reservation.success) {
            uploadFiles.push(fileArray[index]);
            mediaIds.push(reservation.mediaId);
          } else {
            failed.push({
              file: fileArray[index].name,
              error: reservation.error,
            });
          }
        });

        if (!uploadFiles.length) {
          const firstError = failed[0]?.error || "Unable to reserve media items";
          setError(firstError);
          return { success: false, uploaded: 0, failed, error: firstError };
        }

        const uploadResult = await uploadMultiplePhotos(
          uploadFiles,
          familyId,
          userId,
          setUploadProgress,
          {
            mediaIds,
            extractMetadata: true,
            createThumbnail: false,
          },
        );

        await Promise.allSettled(
          uploadResult.failed
            .filter((item) => item.mediaId)
            .map((item) => markMediaUploadFailed(item.mediaId, item.error)),
        );
        failed.push(...uploadResult.failed);

        const finalized = await Promise.all(
          uploadResult.results.map(async (result) => {
            const finalization = await finalizeMediaUpload(result.mediaId, result);
            if (finalization.success) {
              return { success: true, result };
            }

            if (result.path) await deletePhoto(result.path);
            await markMediaUploadFailed(result.mediaId, finalization.error);
            return {
              success: false,
              result,
              error: finalization.error,
            };
          }),
        );

        const finalizedSuccesses = finalized.filter((item) => item.success);
        finalized
          .filter((item) => !item.success)
          .forEach((item) => {
            failed.push({
              file: item.result.file,
              mediaId: item.result.mediaId,
              error: item.error,
            });
          });

        const success = failed.length === 0;
        const firstError = failed[0]?.error;
        if (!success && firstError) setError(firstError);

        return {
          success,
          uploaded: finalizedSuccesses.length,
          failed,
          error: firstError,
        };
      } catch (uploadError) {
        setError(uploadError.message);
        return {
          success: false,
          uploaded: 0,
          failed: [],
          error: uploadError.message,
        };
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
