import { describe, it, expect } from "vitest";
import { formatFileSize } from "./imageMetadata";

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
