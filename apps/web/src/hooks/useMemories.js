/**
 * useMemories Hook
 *
 * Real-time subscription to memory/photo data from Firestore.
 */

import { useState, useEffect, useCallback } from "react";
import { useAuth } from "@/contexts/AuthContext";
import {
  subscribeToMediaItems,
  createMemory,
  updateMemory,
  deleteMemory,
  batchCreateMemories,
} from "@lib/firestore";
import {
  uploadPhoto,
  uploadMultiplePhotos,
  deletePhoto,
  validateFile,
} from "@lib/storage";

/**
 * Hook for managing memories/photos with real-time updates
 * @param {string} familyId - The family ID to fetch memories for
 * @returns {Object} Memories state and actions
 */
export function useMemories(familyId) {
  const { user } = useAuth();
  const [memories, setMemories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [uploading, setUploading] = useState(false);
  const [uploadProgress, setUploadProgress] = useState(0);
  const [error, setError] = useState(null);

  // Subscribe to memories for the family
  useEffect(() => {
    if (!familyId) {
      setMemories([]);
      setLoading(false);
      return;
    }

    setLoading(true);
    const unsubscribe = subscribeToMediaItems(familyId, (data) => {
      setMemories(data);
      setLoading(false);
    });

    return () => unsubscribe();
  }, [familyId]);

  // Upload a single photo and create memory record
  const uploadMemory = useCallback(
    async (file, metadata = {}) => {
      if (!user || !familyId) {
        return {
          success: false,
          error: "Not authenticated or no family selected",
        };
      }

      // Validate file
      const validation = validateFile(file);
      if (!validation.valid) {
        return { success: false, error: validation.error };
      }

      setError(null);
      setUploading(true);
      setUploadProgress(0);

      try {
        // Upload to storage (includes metadata extraction)
        const uploadResult = await uploadPhoto(
          file,
          familyId,
          user.uid,
          (progress) => setUploadProgress(progress),
          { extractMetadata: true, createThumbnail: true },
        );

        if (!uploadResult.success) {
          setError(uploadResult.error);
          setUploading(false);
          return uploadResult;
        }

        // Create memory record in Firestore with extracted metadata
        const memoryResult = await createMemory(familyId, {
          title: metadata.title || file.name,
          description: metadata.description || "",
          photoUrl: uploadResult.url,
          thumbnailUrl: uploadResult.thumbnailUrl || uploadResult.url,
          storagePath: uploadResult.path,
          uploadedBy: user.uid,
          date:
            metadata.date ||
            uploadResult.metadata?.exif?.dateTaken ||
            new Date().toISOString(),
          tags: metadata.tags || [],
          memberIds: metadata.memberIds || [],
          // Store extracted image metadata for future use
          imageMetadata: uploadResult.metadata
            ? {
                width: uploadResult.metadata.width,
                height: uploadResult.metadata.height,
                aspectRatio: uploadResult.metadata.aspectRatio,
                fileSize: uploadResult.metadata.fileSize,
                exif: uploadResult.metadata.exif || {},
                gps: uploadResult.metadata.gps || {},
              }
            : null,
        });

        setUploading(false);
        setUploadProgress(0);

        if (!memoryResult.success) {
          setError(memoryResult.error);
        }

        return {
          success: memoryResult.success,
          memoryId: memoryResult.id,
          photoUrl: uploadResult.url,
          thumbnailUrl: uploadResult.thumbnailUrl,
          metadata: uploadResult.metadata,
          error: memoryResult.error,
        };
      } catch (err) {
        setError(err.message);
        setUploading(false);
        return { success: false, error: err.message };
      }
    },
    [user, familyId],
  );

  // Upload multiple photos
  const uploadMultipleMemories = useCallback(
    async (files, metadata = {}) => {
      if (!user || !familyId) {
        return {
          success: false,
          error: "Not authenticated or no family selected",
        };
      }

      setError(null);
      setUploading(true);
      setUploadProgress(0);

      try {
        const uploadResult = await uploadMultiplePhotos(
          files,
          familyId,
          user.uid,
          (progress) => setUploadProgress(progress),
        );

        // Create memory records for successful uploads using optimized batching
        const memoryData = uploadResult.results.map((result) => ({
          title: result.file,
          description: metadata.description || "",
          photoUrl: result.url,
          storagePath: result.path,
          uploadedBy: user.uid,
          date: metadata.date || new Date().toISOString(),
          tags: metadata.tags || [],
          memberIds: metadata.memberIds || [],
        }));

        await batchCreateMemories(familyId, memoryData);

        setUploading(false);
        setUploadProgress(0);

        return {
          success: uploadResult.failed.length === 0,
          uploaded: uploadResult.results.length,
          failed: uploadResult.failed,
        };
      } catch (err) {
        setError(err.message);
        setUploading(false);
        return { success: false, error: err.message };
      }
    },
    [user, familyId],
  );

  // Update a memory
  const editMemory = useCallback(
    async (memoryId, updates) => {
      if (!familyId) return { success: false, error: "No family selected" };

      setError(null);
      const result = await updateMemory(familyId, memoryId, updates);

      if (!result.success) {
        setError(result.error);
      }
      return result;
    },
    [familyId],
  );

  // Delete a memory (also deletes from storage)
  const removeMemory = useCallback(
    async (memoryId, storagePath) => {
      if (!familyId) return { success: false, error: "No family selected" };

      setError(null);

      // Delete from storage first
      if (storagePath) {
        await deletePhoto(storagePath);
      }

      // Delete from Firestore
      const result = await deleteMemory(familyId, memoryId);

      if (!result.success) {
        setError(result.error);
      }
      return result;
    },
    [familyId],
  );

  return {
    // State
    memories,
    loading,
    uploading,
    uploadProgress,
    error,

    // Actions
    uploadMemory,
    uploadMultipleMemories,
    editMemory,
    removeMemory,
  };
}

export default useMemories;
