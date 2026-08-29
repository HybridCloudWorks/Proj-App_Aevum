import { act, renderHook, waitFor } from "@testing-library/react";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { useAuth } from "@/contexts/AuthContext";
import {
  finalizeMediaUpload,
  markMediaUploadFailed,
  reserveMediaItem,
  subscribeToMediaItems,
} from "@lib/firestore";
import {
  deletePhoto,
  uploadPhoto,
  validateFile,
} from "@lib/storage";
import { useMemories } from "./useMemories";

vi.mock("@/contexts/AuthContext", () => ({
  useAuth: vi.fn(),
}));

vi.mock("@lib/firestore", () => ({
  deleteMemory: vi.fn(),
  finalizeMediaUpload: vi.fn(),
  markMediaUploadFailed: vi.fn(),
  reserveMediaItem: vi.fn(),
  subscribeToMediaItems: vi.fn(),
  updateMemory: vi.fn(),
}));

vi.mock("@lib/storage", () => ({
  deletePhoto: vi.fn(),
  uploadMultiplePhotos: vi.fn(),
  uploadPhoto: vi.fn(),
  validateFile: vi.fn(),
}));

const familyId = "family-a";
const userId = "owner-a";
const file = new File(["photo"], "family-photo.jpg", {
  type: "image/jpeg",
});

describe("useMemories canonical upload lifecycle", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    useAuth.mockReturnValue({ user: { uid: userId } });
    validateFile.mockReturnValue({ valid: true });
    subscribeToMediaItems.mockReturnValue(vi.fn());
    markMediaUploadFailed.mockResolvedValue({ success: true });
    deletePhoto.mockResolvedValue({ success: true });
  });

  it("reserves a media ID, uploads to that ID, and finalizes metadata", async () => {
    reserveMediaItem.mockResolvedValue({
      success: true,
      mediaId: "media-1",
    });
    uploadPhoto.mockResolvedValue({
      success: true,
      mediaId: "media-1",
      url: "https://example.test/original",
      path: "families/family-a/media/media-1/original/family-photo.jpg",
      thumbnailUrl: null,
      metadata: { width: 1200, height: 800 },
    });
    finalizeMediaUpload.mockResolvedValue({ success: true });

    const { result } = renderHook(() => useMemories(familyId));
    let uploadResult;

    await act(async () => {
      uploadResult = await result.current.uploadMemory(file, {
        title: "Family photo",
      });
    });

    expect(reserveMediaItem).toHaveBeenCalledWith(
      familyId,
      userId,
      expect.objectContaining({
        title: "Family photo",
        originalFileName: "family-photo.jpg",
      }),
    );
    expect(uploadPhoto).toHaveBeenCalledWith(
      file,
      familyId,
      userId,
      expect.any(Function),
      expect.objectContaining({ mediaId: "media-1" }),
    );
    expect(finalizeMediaUpload).toHaveBeenCalledWith(
      "media-1",
      expect.objectContaining({
        path: "families/family-a/media/media-1/original/family-photo.jpg",
      }),
    );
    expect(uploadResult).toEqual(
      expect.objectContaining({
        success: true,
        mediaId: "media-1",
        status: "uploaded",
      }),
    );
    expect(markMediaUploadFailed).not.toHaveBeenCalled();
  });

  it("deletes the uploaded original and records failure if finalization fails", async () => {
    const originalPath =
      "families/family-a/media/media-2/original/family-photo.jpg";
    reserveMediaItem.mockResolvedValue({
      success: true,
      mediaId: "media-2",
    });
    uploadPhoto.mockResolvedValue({
      success: true,
      mediaId: "media-2",
      url: "https://example.test/original",
      path: originalPath,
      thumbnailUrl: null,
      metadata: null,
    });
    finalizeMediaUpload.mockResolvedValue({
      success: false,
      error: "Firestore unavailable",
    });

    const { result } = renderHook(() => useMemories(familyId));
    let uploadResult;

    await act(async () => {
      uploadResult = await result.current.uploadMemory(file);
    });

    expect(deletePhoto).toHaveBeenCalledWith(originalPath);
    expect(markMediaUploadFailed).toHaveBeenCalledWith(
      "media-2",
      "Firestore unavailable",
    );
    expect(uploadResult).toEqual(
      expect.objectContaining({
        success: false,
        memoryId: "media-2",
        error: "Firestore unavailable",
      }),
    );
  });

  it("records an upload failure without attempting metadata finalization", async () => {
    reserveMediaItem.mockResolvedValue({
      success: true,
      mediaId: "media-3",
    });
    uploadPhoto.mockResolvedValue({
      success: false,
      mediaId: "media-3",
      error: "Storage denied",
    });

    const { result } = renderHook(() => useMemories(familyId));

    await act(async () => {
      await result.current.uploadMemory(file);
    });

    expect(markMediaUploadFailed).toHaveBeenCalledWith(
      "media-3",
      "Storage denied",
    );
    expect(finalizeMediaUpload).not.toHaveBeenCalled();
    expect(deletePhoto).not.toHaveBeenCalled();
  });

  it("rejects uploads before reservation when authentication is absent", async () => {
    useAuth.mockReturnValue({ user: null });

    const { result } = renderHook(() => useMemories(familyId));
    let uploadResult;

    await act(async () => {
      uploadResult = await result.current.uploadMemory(file);
    });

    expect(uploadResult).toEqual({
      success: false,
      error: "Not authenticated or no family selected",
    });
    expect(reserveMediaItem).not.toHaveBeenCalled();
    expect(uploadPhoto).not.toHaveBeenCalled();
  });

  it("restores canonical media through the family subscription after mount", async () => {
    const canonicalMedia = [
      {
        id: "media-4",
        familyId,
        status: "processed",
        storage: {
          originalPath:
            "families/family-a/media/media-4/original/family-photo.jpg",
          thumbnailPath:
            "families/family-a/media/media-4/derived/1/thumbnail.webp",
        },
      },
    ];
    subscribeToMediaItems.mockImplementation(
      (requestedFamilyId, onData) => {
        onData(canonicalMedia);
        return vi.fn();
      },
    );

    const { result } = renderHook(() => useMemories(familyId));

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
      expect(result.current.memories).toEqual(canonicalMedia);
    });
    expect(subscribeToMediaItems).toHaveBeenCalledWith(
      familyId,
      expect.any(Function),
      20,
      expect.any(Function),
    );
  });
});
