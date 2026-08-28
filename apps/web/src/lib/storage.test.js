import { beforeEach, describe, expect, it, vi } from "vitest";
import {
  getDownloadURL,
  listAll,
  uploadBytesResumable,
} from "firebase/storage";
import * as imageMetadata from "./imageMetadata";
import {
  listFamilyPhotos,
  uploadMultiplePhotos,
  uploadPhoto,
  validateFile,
} from "./storage";

vi.mock("firebase/storage", () => ({
  ref: vi.fn((_storage, path) => ({
    name: path?.split("/").pop() || "",
    fullPath: path || "",
  })),
  uploadBytesResumable: vi.fn(),
  getDownloadURL: vi.fn(),
  deleteObject: vi.fn(),
  listAll: vi.fn(),
}));

vi.mock("./firebase", () => ({ storage: {} }));

vi.mock("./imageMetadata", () => ({
  extractImageMetadata: vi.fn(),
  createThumbnail: vi.fn(),
}));

function completedUploadTask(name) {
  const task = {
    snapshot: { ref: { name, fullPath: name } },
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
  it("accepts a valid image", () => {
    expect(
      validateFile({ type: "image/jpeg", size: 5 * 1024 * 1024 }),
    ).toEqual({ valid: true });
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

  it("honors custom validation options", () => {
    expect(
      validateFile(
        { type: "image/gif", size: 1024 },
        { allowedTypes: ["image/gif"] },
      ),
    ).toEqual({ valid: true });

    expect(
      validateFile(
        { type: "image/jpeg", size: 2 * 1024 * 1024 },
        { maxSizeMB: 1 },
      ).valid,
    ).toBe(false);
  });
});

describe("listFamilyPhotos", () => {
  beforeEach(() => vi.clearAllMocks());

  it("returns metadata without pre-fetching download URLs", async () => {
    listAll.mockResolvedValue({
      items: [
        {
          name: "photo1.jpg",
          fullPath: "families/123/memories/photo1.jpg",
        },
        {
          name: "photo2.jpg",
          fullPath: "families/123/memories/photo2.jpg",
        },
      ],
    });

    const result = await listFamilyPhotos("123");
    expect(result.success).toBe(true);
    expect(result.photos).toEqual([
      {
        name: "photo1.jpg",
        path: "families/123/memories/photo1.jpg",
      },
      {
        name: "photo2.jpg",
        path: "families/123/memories/photo2.jpg",
      },
    ]);
    expect(getDownloadURL).not.toHaveBeenCalled();
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
    imageMetadata.createThumbnail.mockResolvedValue(null);
    getDownloadURL.mockResolvedValue("https://example.test/photo.jpg");
  });

  it("uploads an image and optional thumbnail", async () => {
    const mainTask = completedUploadTask("main");
    const thumbnailTask = completedUploadTask("thumbnail");
    uploadBytesResumable
      .mockReturnValueOnce(mainTask)
      .mockReturnValueOnce(thumbnailTask);
    imageMetadata.createThumbnail.mockResolvedValue(
      new Blob(["thumb"], { type: "image/jpeg" }),
    );
    getDownloadURL.mockImplementation((storageRef) =>
      Promise.resolve(
        storageRef.name === "thumbnail"
          ? "https://example.test/thumb.jpg"
          : "https://example.test/photo.jpg",
      ),
    );

    const file = new File(["content"], "test.jpg", { type: "image/jpeg" });
    const result = await uploadPhoto(file, "family", "user");

    expect(result.success).toBe(true);
    expect(result.url).toBe("https://example.test/photo.jpg");
    expect(result.thumbnailUrl).toBe("https://example.test/thumb.jpg");
    expect(result.metadata.width).toBe(1000);
  });

  it("continues when metadata extraction fails", async () => {
    const metadataError = new Error("metadata failed");
    imageMetadata.extractImageMetadata.mockRejectedValue(metadataError);
    uploadBytesResumable.mockReturnValue(completedUploadTask("main"));
    const warning = vi.spyOn(console, "warn").mockImplementation(() => {});

    const file = new File(["content"], "test.jpg", { type: "image/jpeg" });
    const result = await uploadPhoto(file, "family", "user", () => {}, {
      extractMetadata: true,
      createThumbnail: false,
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
    imageMetadata.createThumbnail.mockResolvedValue(null);
    getDownloadURL.mockResolvedValue("https://example.test/photo.jpg");
  });

  it("tracks aggregate progress and returns successful files", async () => {
    const controls = [];
    uploadBytesResumable.mockImplementation((_storageRef, file) => {
      const task = {
        snapshot: { ref: { name: file.name, fullPath: file.name } },
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

    const promise = uploadMultiplePhotos(files, "family", "user", onProgress);
    await vi.waitFor(() => expect(controls).toHaveLength(2));

    controls[0].progress({ bytesTransferred: 50, totalBytes: 100 });
    expect(onProgress).toHaveBeenCalledWith(20);

    controls[1].progress({ bytesTransferred: 100, totalBytes: 100 });
    expect(onProgress).toHaveBeenCalledWith(60);

    controls[0].complete();
    controls[1].complete();

    const result = await promise;
    expect(result.success).toBe(true);
    expect(result.results).toHaveLength(2);
    expect(result.failed).toEqual([]);
    expect(onProgress).toHaveBeenLastCalledWith(100);
  });
});
