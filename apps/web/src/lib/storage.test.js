import { describe, it, expect, vi } from "vitest";
import { validateFile, uploadMultiplePhotos } from "./storage";
import * as storageExports from "./storage";
import { uploadBytesResumable, getDownloadURL } from "firebase/storage";

// Mock the dependencies of storage.js to avoid initialization issues
vi.mock("firebase/storage", () => ({
  ref: vi.fn(),
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
  });
});
