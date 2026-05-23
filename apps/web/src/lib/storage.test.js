import { describe, it, expect, vi, beforeEach } from "vitest";
import { validateFile, uploadPhoto } from "./storage";
import * as storageMethods from "firebase/storage";
import * as imageMetadata from "./imageMetadata";

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
  extractImageMetadata: vi.fn(),
  createThumbnail: vi.fn(),
}));

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
  });
});
