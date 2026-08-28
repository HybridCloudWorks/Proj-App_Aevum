import { beforeEach, describe, expect, it, vi } from "vitest";
import { getDownloadURL, uploadBytesResumable } from "firebase/storage";
import * as imageMetadata from "./imageMetadata";
import { uploadMultiplePhotos, uploadPhoto, validateFile } from "./storage";

vi.mock("firebase/storage", () => ({
  ref: vi.fn((_storage, path) => ({
    name: path?.split("/").pop() || "",
    fullPath: path || "",
  })),
  uploadBytesResumable: vi.fn(),
  getDownloadURL: vi.fn(),
  deleteObject: vi.fn(),
}));

vi.mock("./firebase", () => ({ storage: {} }));

vi.mock("./imageMetadata", () => ({
  extractImageMetadata: vi.fn(),
}));

function completedUploadTask(storageRef) {
  const task = {
    snapshot: { ref: storageRef },
    on: vi.fn((_event, progress, _error, complete) => {
      progress({ bytesTransferred: 100, totalBytes: 100 });
      complete();
    }),
    then(resolve, reject) {
      return Promise.resolve(task.snapshot).then(resolve, reject);
    },
  };
  return task;
}

describe("validateFile", () => {
  it("accepts supported image formats including HEIF", () => {
    expect(
      validateFile({ type: "image/jpeg", size: 5 * 1024 * 1024 }),
    ).toEqual({ valid: true });
    expect(validateFile({ type: "image/heif", size: 1024 })).toEqual({
      valid: true,
    });
  });

  it("rejects a missing file", () => {
    expect(validateFile(null)).toEqual({
      valid: false,
      error: "No file provided.",
    });
  });

  it("rejects unsupported types", () => {
    const result = validateFile({ type: "application/pdf", size: 1024 });
    expect(result.valid).toBe(false);
    expect(result.error).toContain("File type not supported");
  });

  it("rejects files above the size limit", () => {
    const result = validateFile({
      type: "image/png",
      size: 11 * 1024 * 1024,
    });
    expect(result.valid).toBe(false);
    expect(result.error).toContain("File size exceeds 10MB limit");
  });
});

describe("uploadPhoto", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    imageMetadata.extractImageMetadata.mockResolvedValue({
      width: 1000,
      height: 800,
      aspectRatio: "1.25",
      exif: {},
      gps: {},
    });
    getDownloadURL.mockResolvedValue("https://example.test/photo.jpg");
    uploadBytesResumable.mockImplementation((storageRef) =>
      completedUploadTask(storageRef),
    );
  });

  it("requires a reserved mediaId", async () => {
    const file = new File(["content"], "test.jpg", { type: "image/jpeg" });
    const result = await uploadPhoto(file, "family", "user");

    expect(result.success).toBe(false);
    expect(result.error).toContain("reserved mediaId");
    expect(uploadBytesResumable).not.toHaveBeenCalled();
  });

  it("uploads only the canonical immutable original", async () => {
    const file = new File(["content"], "test.jpg", { type: "image/jpeg" });
    const result = await uploadPhoto(file, "family", "user", () => {}, {
      mediaId: "media-1",
    });

    expect(result.success).toBe(true);
    expect(result.mediaId).toBe("media-1");
    expect(result.path).toBe(
      "families/family/media/media-1/original/test.jpg",
    );
    expect(result.thumbnailUrl).toBeNull();
    expect(uploadBytesResumable).toHaveBeenCalledTimes(1);
    expect(uploadBytesResumable.mock.calls[0][0].fullPath).toBe(
      "families/family/media/media-1/original/test.jpg",
    );
  });

  it("continues when metadata extraction fails", async () => {
    const metadataError = new Error("metadata failed");
    imageMetadata.extractImageMetadata.mockRejectedValue(metadataError);
    const warning = vi.spyOn(console, "warn").mockImplementation(() => {});

    const file = new File(["content"], "test.jpg", { type: "image/jpeg" });
    const result = await uploadPhoto(file, "family", "user", () => {}, {
      mediaId: "media-1",
    });

    expect(result.success).toBe(true);
    expect(result.metadata).toBeNull();
    expect(warning).toHaveBeenCalledWith(
      "Metadata extraction failed:",
      metadataError,
    );
    warning.mockRestore();
  });
});

describe("uploadMultiplePhotos", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    imageMetadata.extractImageMetadata.mockResolvedValue({
      width: 100,
      height: 100,
      exif: {},
      gps: {},
    });
    getDownloadURL.mockResolvedValue("https://example.test/photo.jpg");
  });

  it("rejects a batch without one reserved mediaId per file", async () => {
    const files = [
      new File(["a"], "one.jpg", { type: "image/jpeg" }),
      new File(["b"], "two.jpg", { type: "image/jpeg" }),
    ];

    const result = await uploadMultiplePhotos(files, "family", "user");
    expect(result.success).toBe(false);
    expect(result.results).toEqual([]);
    expect(result.failed).toHaveLength(2);
    expect(uploadBytesResumable).not.toHaveBeenCalled();
  });

  it("tracks aggregate progress for canonical media IDs", async () => {
    const controls = [];
    uploadBytesResumable.mockImplementation((storageRef) => {
      const task = {
        snapshot: { ref: storageRef },
        on: vi.fn((_event, progress, error, complete) => {
          controls.push({ progress, error, complete });
        }),
        then(resolve, reject) {
          return Promise.resolve(task.snapshot).then(resolve, reject);
        },
      };
      return task;
    });

    const onProgress = vi.fn();
    const files = [
      new File(["a"], "one.jpg", { type: "image/jpeg" }),
      new File(["b"], "two.jpg", { type: "image/jpeg" }),
    ];

    const promise = uploadMultiplePhotos(
      files,
      "family",
      "user",
      onProgress,
      { mediaIds: ["media-1", "media-2"] },
    );
    await vi.waitFor(() => expect(controls).toHaveLength(2));

    controls[0].progress({ bytesTransferred: 50, totalBytes: 100 });
    expect(onProgress).toHaveBeenCalledWith(25);

    controls[1].progress({ bytesTransferred: 100, totalBytes: 100 });
    expect(onProgress).toHaveBeenCalledWith(75);

    controls[0].complete();
    controls[1].complete();

    const result = await promise;
    expect(result.success).toBe(true);
    expect(result.results.map((item) => item.mediaId)).toEqual([
      "media-1",
      "media-2",
    ]);
    expect(result.failed).toEqual([]);
    expect(onProgress).toHaveBeenLastCalledWith(100);
  });
});
