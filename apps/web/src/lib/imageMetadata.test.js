import { describe, it, expect, vi, beforeAll, afterAll } from "vitest";
import {
  formatFileSize,
  getImageQuality,
  createThumbnail,
} from "./imageMetadata";

describe("formatFileSize", () => {
  it("should format 0 bytes correctly", () => {
    expect(formatFileSize(0)).toBe("0 B");
  });

  it("should format bytes less than 1KB correctly", () => {
    expect(formatFileSize(500)).toBe("500 B");
    expect(formatFileSize(1023)).toBe("1023 B");
  });

  it("should format exactly 1KB correctly", () => {
    expect(formatFileSize(1024)).toBe("1 KB");
  });

  it("should format partial KBs correctly", () => {
    expect(formatFileSize(1536)).toBe("1.5 KB");
    expect(formatFileSize(1280)).toBe("1.3 KB"); // Rounding 1.25 -> 1.3
  });

  it("should format MBs correctly", () => {
    expect(formatFileSize(1048576)).toBe("1 MB");
    expect(formatFileSize(1048576 * 1.5)).toBe("1.5 MB");
  });

  it("should format GBs correctly", () => {
    expect(formatFileSize(1073741824)).toBe("1 GB");
    expect(formatFileSize(1073741824 * 2.7)).toBe("2.7 GB");
  });

  it("should handle large values by rounding to one decimal place", () => {
    expect(formatFileSize(1229)).toBe("1.2 KB"); // 1229 / 1024 = 1.20019...
  });
});

describe("getImageQuality", () => {
  it("should return Excellent for 8MP and above", () => {
    // 8MP: 4000 x 2000 = 8,000,000
    expect(getImageQuality(4000, 2000)).toEqual({
      label: "Excellent",
      color: "green",
    });
    // 12MP: 4000 x 3000 = 12,000,000
    expect(getImageQuality(4000, 3000)).toEqual({
      label: "Excellent",
      color: "green",
    });
  });

  it("should return Good for 4MP to < 8MP", () => {
    // 4MP: 2000 x 2000 = 4,000,000
    expect(getImageQuality(2000, 2000)).toEqual({
      label: "Good",
      color: "blue",
    });
    // 6MP: 3000 x 2000 = 6,000,000
    expect(getImageQuality(3000, 2000)).toEqual({
      label: "Good",
      color: "blue",
    });
    // Just under 8MP: 7,999,999
    expect(getImageQuality(7999.999, 1000)).toEqual({
      label: "Good",
      color: "blue",
    });
  });

  it("should return Fair for 2MP to < 4MP", () => {
    // 2MP: 2000 x 1000 = 2,000,000
    expect(getImageQuality(2000, 1000)).toEqual({
      label: "Fair",
      color: "yellow",
    });
    // 3MP: 2000 x 1500 = 3,000,000
    expect(getImageQuality(2000, 1500)).toEqual({
      label: "Fair",
      color: "yellow",
    });
    // Just under 4MP
    expect(getImageQuality(3999, 1000)).toEqual({
      label: "Fair",
      color: "yellow",
    });
  });

  it("should return Low for less than 2MP", () => {
    // 1MP: 1000 x 1000 = 1,000,000
    expect(getImageQuality(1000, 1000)).toEqual({ label: "Low", color: "red" });
    // 0.25MP: 500 x 500 = 250,000
    expect(getImageQuality(500, 500)).toEqual({ label: "Low", color: "red" });
    // Just under 2MP
    expect(getImageQuality(1999, 1000)).toEqual({ label: "Low", color: "red" });
  });

  it("should handle zero or near-zero dimensions", () => {
    expect(getImageQuality(0, 0)).toEqual({ label: "Low", color: "red" });
    expect(getImageQuality(1, 1)).toEqual({ label: "Low", color: "red" });
  });
});

describe("createThumbnail", () => {
  // Setup mocks
  beforeAll(() => {
    // Mock URL
    globalThis.URL.createObjectURL = vi.fn(() => "blob:test");
    globalThis.URL.revokeObjectURL = vi.fn();

    // Mock document and canvas
    const mockContext = {
      drawImage: vi.fn(),
    };
    const mockCanvas = {
      width: 0,
      height: 0,
      getContext: vi.fn(() => mockContext),
      toBlob: vi.fn((cb) => cb("blob-data")),
    };

    // Check if document exists (jsdom) or mock it
    if (typeof document === "undefined") {
      globalThis.document = {
        createElement: vi.fn(() => mockCanvas),
      };
    } else {
      vi.spyOn(document, "createElement").mockReturnValue(mockCanvas);
    }

    // Mock Image
    globalThis.Image = class {
      constructor() {
        this.naturalWidth = 1000;
        this.naturalHeight = 1000;
        setTimeout(() => this.onload && this.onload(), 10);
      }
    };
  });

  it("should use createImageBitmap if available", async () => {
    const file = new File(["content"], "test.jpg", { type: "image/jpeg" });
    const mockBitmap = {
      width: 1000,
      height: 1000,
      close: vi.fn(),
    };

    globalThis.createImageBitmap = vi.fn().mockResolvedValue(mockBitmap);

    await createThumbnail(file, 200);

    expect(globalThis.createImageBitmap).toHaveBeenCalled();
  });

  it("should fallback to Image if createImageBitmap is undefined", async () => {
    const file = new File(["content"], "test.jpg", { type: "image/jpeg" });

    // Temporarily remove createImageBitmap
    const originalCreateImageBitmap = globalThis.createImageBitmap;
    globalThis.createImageBitmap = undefined;

    // Reset mocks
    globalThis.URL.createObjectURL.mockClear();

    await createThumbnail(file, 200);

    expect(globalThis.URL.createObjectURL).toHaveBeenCalled();

    // Restore
    globalThis.createImageBitmap = originalCreateImageBitmap;
  });
});
