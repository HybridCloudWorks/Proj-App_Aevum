import { describe, it, expect, vi } from "vitest";
import { validateFile } from "./storage";

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
