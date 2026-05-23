import { describe, it, expect, vi, beforeEach } from "vitest";
import { validateFile, uploadPhoto } from "./storage";
import * as storageMethods from "firebase/storage";
import * as imageMetadata from "./imageMetadata";
import { describe, it, expect, vi } from "vitest";
import { validateFile, uploadMultiplePhotos } from "./storage";
import * as storageExports from "./storage";
import { validateFile, listFamilyPhotos } from "./storage";
import { listAll, getDownloadURL } from "firebase/storage";
import { validateFile, uploadMultiplePhotos } from "./storage";
import { uploadBytesResumable, getDownloadURL } from "firebase/storage";

// Mock the dependencies of storage.js to avoid initialization issues
// vi.mock calls are hoisted by Vitest
vi.mock("firebase/storage", () => ({
  ref: vi.fn((storage, path) => ({ _path: path, name: path ? path.split("/").pop() : "" })),
  uploadBytesResumable: vi.fn(),
  getDownloadURL: vi.fn(),
  deleteObject: vi.fn(),
  listAll: vi.fn(),
}));

vi.mock("./firebase", () => ({
  storage: {},
}));

vi.mock("./imageMetadata", () => ({
  extractImageMetadata: vi.fn().mockResolvedValue({ width: 100, height: 100 }),
  createThumbnail: vi.fn().mockResolvedValue(new Blob()),
}));

describe("listFamilyPhotos", () => {
  it("should return photo metadata and NOT call getDownloadURL", async () => {
    const mockItems = [
      { name: "photo1.jpg", fullPath: "families/123/memories/photo1.jpg" },
      { name: "photo2.jpg", fullPath: "families/123/memories/photo2.jpg" },
    ];
    listAll.mockResolvedValueOnce({ items: mockItems });

    const result = await listFamilyPhotos("123");

    expect(result.success).toBe(true);
    expect(result.photos).toHaveLength(2);
    expect(result.photos[0]).toEqual({
      name: "photo1.jpg",
      path: "families/123/memories/photo1.jpg",
    });
    expect(result.photos[0].url).toBeUndefined();
    expect(getDownloadURL).not.toHaveBeenCalled();
  });
});

describe("validateFile", () => {
  it("should return valid: true for a valid file", () => {
    const file = {
      type: "image/jpeg",
      size: 5 * 1024 * 1024, // 5MB
    };
    const result = validateFile(file);
    expect(result).toEqual({ valid: true });
  });

  it("should return valid: false if no file is provided", () => {
    const result = validateFile(null);
    expect(result.valid).toBe(false);
    expect(result.error).toBe("No file provided.");
  });

  it("should return valid: false for unsupported file types", () => {
    const file = {
      type: "application/pdf",
      size: 1024,
    };
    const result = validateFile(file);
    expect(result.valid).toBe(false);
    expect(result.error).toContain("File type not supported");
  });

  it("should return valid: false if file size exceeds the default limit", () => {
    const file = {
      type: "image/png",
      size: 11 * 1024 * 1024, // 11MB
    };
    const result = validateFile(file);
    expect(result.valid).toBe(false);
    expect(result.error).toContain("File size exceeds 10MB limit");
  });

  it("should respect custom allowedTypes option", () => {
    const file = {
      type: "image/gif",
      size: 1024,
    };
    const options = { allowedTypes: ["image/gif"] };
    const result = validateFile(file, options);
    expect(result.valid).toBe(true);
  });

  it("should respect custom maxSizeMB option", () => {
    const file = {
      type: "image/jpeg",
      size: 2 * 1024 * 1024, // 2MB
    };
    const options = { maxSizeMB: 1 };
    const result = validateFile(file, options);
    expect(result.valid).toBe(false);
    expect(result.error).toContain("File size exceeds 1MB limit");
  });

  it("should return valid: true if file size is exactly at the limit", () => {
    const maxSizeMB = 10;
    const file = {
      type: "image/jpeg",
      size: maxSizeMB * 1024 * 1024,
    };
    const result = validateFile(file, { maxSizeMB });
    expect(result.valid).toBe(true);
  });
});

describe("uploadMultiplePhotos", () => {
  it("should calculate correct overall progress incrementally", async () => {
    const files = [
      { name: "file1.jpg", type: "image/jpeg", size: 1024 },
      { name: "file2.jpg", type: "image/jpeg", size: 1024 },
    ];
    const familyId = "family123";
    const userId = "user456";
    const progressUpdates = [];
    const onProgress = (progress) => progressUpdates.push(progress);

    // Mock uploadBytesResumable to capture the progress callback
    let progressCallback1, progressCallback2;
    uploadBytesResumable
      .mockImplementationOnce((ref, file) => {
        return {
          on: (event, progress, error, complete) => {
            progressCallback1 = progress;
            // Simulate completion immediately for simplicity in this test,
            // or just don't call it if we only care about progress
            setTimeout(() => complete(), 10);
          },
          snapshot: { ref: {} },
        };
      })
      .mockImplementationOnce((ref, file) => {
        return {
          on: (event, progress, error, complete) => {
            progressCallback2 = progress;
            setTimeout(() => complete(), 10);
          },
          snapshot: { ref: {} },
        };
      });

    getDownloadURL.mockResolvedValue("http://example.com/file.jpg");

    const uploadPromise = uploadMultiplePhotos(
      files,
      familyId,
      userId,
      onProgress,
    );

    // Wait a bit for the promises to start
    await new Promise((resolve) => setTimeout(resolve, 0));

    // Simulate progress updates
    // Total files = 2
    // progress in uploadPhoto is (snapshot.bytesTransferred / snapshot.totalBytes) * 100 * 0.8
    // So 50% physical progress = 40% logical progress in uploadPhoto

    if (progressCallback1) {
      progressCallback1({ bytesTransferred: 50, totalBytes: 100 }); // 40% for file 1
    }
    if (progressCallback2) {
      progressCallback2({ bytesTransferred: 25, totalBytes: 100 }); // 20% for file 2
    }

    // Expected overall progress = (40 + 20) / 2 = 30%
    // Note: progressUpdates might contain more values if onProgress is called multiple times

    expect(progressUpdates).toContain(20); // (40 + 0) / 2
    expect(progressUpdates).toContain(30); // (40 + 20) / 2

    await uploadPromise;

    // Final progress should be 100
    expect(progressUpdates[progressUpdates.length - 1]).toBe(100);
describe("uploadPhoto", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  const createMockUploadTask = (refName) => {
    const task = {
      on: vi.fn((event, progressCb, errorCb, completeCb) => {
        if (event === "state_changed") {
          progressCb({ bytesTransferred: 100, totalBytes: 100 });
          setTimeout(() => {
            task.snapshot = { ref: { name: refName } };
            completeCb();
          }, 0);
        }
      }),
      then: vi.fn((resolve) => {
        const result = { ref: { name: refName } };
        if (resolve) resolve(result);
        return Promise.resolve(result);
      }),
      catch: vi.fn().mockReturnThis(),
    };
    return task;
  };

  it("should upload a photo successfully (happy path)", async () => {
    const file = new File(["content"], "test.jpg", { type: "image/jpeg" });
    const familyId = "family123";
    const userId = "user456";

    imageMetadata.extractImageMetadata.mockResolvedValue({ width: 1000, height: 800 });
    imageMetadata.createThumbnail.mockResolvedValue(new Blob(["thumb"], { type: "image/jpeg" }));

    const mainTask = createMockUploadTask("main_ref");
    const thumbTask = createMockUploadTask("thumb_ref");

    storageMethods.uploadBytesResumable
      .mockReturnValueOnce(mainTask)
      .mockReturnValueOnce(thumbTask);

    storageMethods.getDownloadURL.mockImplementation((ref) => {
      if (ref && ref.name === "thumb_ref") return Promise.resolve("http://example.com/thumb.jpg");
      return Promise.resolve("http://example.com/photo.jpg");
    });

    const result = await uploadPhoto(file, familyId, userId);

    expect(result.success).toBe(true);
    expect(result.url).toBe("http://example.com/photo.jpg");
    expect(result.thumbnailUrl).toBe("http://example.com/thumb.jpg");
    expect(result.metadata).toEqual({ width: 1000, height: 800 });
  });

  it("should continue upload even if metadata extraction fails", async () => {
    const file = new File(["content"], "test.jpg", { type: "image/jpeg" });
    const familyId = "family123";
    const userId = "user456";

    const error = new Error("Metadata extraction error");
    imageMetadata.extractImageMetadata.mockRejectedValue(error);

    const warnSpy = vi.spyOn(console, "warn").mockImplementation(() => {});

    const mainTask = createMockUploadTask("main_ref");
    storageMethods.uploadBytesResumable.mockReturnValue(mainTask);
    storageMethods.getDownloadURL.mockResolvedValue("http://example.com/photo.jpg");

    const result = await uploadPhoto(file, familyId, userId, () => {}, { extractMetadata: true, createThumbnail: false });

    expect(result.success).toBe(true);
    expect(result.url).toBe("http://example.com/photo.jpg");
    expect(result.metadata).toBeNull();
    expect(warnSpy).toHaveBeenCalledWith("Metadata extraction failed:", error);

    warnSpy.mockRestore();
describe("uploadMultiplePhotos", () => {
  it("should track overall progress correctly for multiple files", async () => {
    const files = [
      { name: "file1.jpg", type: "image/jpeg", size: 100 },
      { name: "file2.jpg", type: "image/jpeg", size: 100 },
    ];

    const onProgress = vi.fn();

    // Mock uploadBytesResumable to capture the progress callback
    let progressCallbacks = [];
    uploadBytesResumable.mockImplementation(() => ({
      on: vi.fn((event, progressFn, errorFn, completeFn) => {
        progressCallbacks.push(progressFn);
        // Simulate completion immediately in the next tick
        setTimeout(() => completeFn(), 50);
      }),
      snapshot: { ref: {} },
    }));

    getDownloadURL.mockResolvedValue("http://example.com/photo.jpg");

    const uploadPromise = uploadMultiplePhotos(
      files,
      "family123",
      "user456",
      onProgress,
    );

    // Wait for the uploadPhoto calls to set up their tasks
    await new Promise((resolve) => setTimeout(resolve, 20));

    // We expect 2 progress callbacks (one for each file's main upload)
    expect(progressCallbacks.length).toBe(2);

    // Trigger progress for file 1: 50%
    // uploadPhoto scales this by 0.8 -> 40%
    progressCallbacks[0]({ bytesTransferred: 50, totalBytes: 100 });
    // Overall: (40 + 0) / 2 = 20%
    expect(onProgress).toHaveBeenCalledWith(20);

    // Trigger progress for file 2: 100%
    // uploadPhoto scales this by 0.8 -> 80%
    progressCallbacks[1]({ bytesTransferred: 100, totalBytes: 100 });
    // Overall: (40 + 80) / 2 = 60%
    expect(onProgress).toHaveBeenCalledWith(60);

    await uploadPromise;

    // Finally should reach 100%
    expect(onProgress).toHaveBeenLastCalledWith(100);
  });
});
