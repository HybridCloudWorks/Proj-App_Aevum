/**
 * Image Metadata Extraction Service
 *
 * Extracts EXIF and image metadata for storage in Firestore.
 * Useful for photo organization, date detection, and location mapping.
 */

/**
 * Extract metadata from an image file
 * @param {File} file - The image file
 * @returns {Promise<Object>} Extracted metadata
 */
export async function extractImageMetadata(file) {
  const metadata = {
    // Basic file info
    fileName: file.name,
    fileSize: file.size,
    fileType: file.type,
    lastModified: new Date(file.lastModified).toISOString(),

    // Image dimensions (extracted after loading)
    width: null,
    height: null,
    aspectRatio: null,

    // EXIF data (if available)
    exif: {
      dateTaken: null,
      camera: null,
      lens: null,
      focalLength: null,
      aperture: null,
      shutterSpeed: null,
      iso: null,
      flash: null,
      orientation: null,
    },

    // GPS data (if available)
    gps: {
      latitude: null,
      longitude: null,
      altitude: null,
      locationName: null,
    },

    // Processing metadata
    extractedAt: new Date().toISOString(),
    processingStatus: "pending",
  };

  try {
    // Get image dimensions
    const dimensions = await getImageDimensions(file);
    metadata.width = dimensions.width;
    metadata.height = dimensions.height;
    metadata.aspectRatio = (dimensions.width / dimensions.height).toFixed(2);

    // Extract EXIF data
    const exifData = await extractExifData(file);
    if (exifData) {
      metadata.exif = { ...metadata.exif, ...exifData };
      if (exifData.gps) {
        metadata.gps = { ...metadata.gps, ...exifData.gps };
      }
    }

    metadata.processingStatus = "complete";
  } catch (error) {
    console.error("Error extracting metadata:", error);
    metadata.processingStatus = "error";
    metadata.error = error.message;
  }

  return metadata;
}

/**
 * Get image dimensions by loading into an Image element
 */
function getImageDimensions(file) {
  return new Promise((resolve, reject) => {
    const img = new Image();
    const url = URL.createObjectURL(file);

    img.onload = () => {
      URL.revokeObjectURL(url);
      resolve({ width: img.naturalWidth, height: img.naturalHeight });
    };

    img.onerror = () => {
      URL.revokeObjectURL(url);
      reject(new Error("Failed to load image"));
    };

    img.src = url;
  });
}

// Optimization: Reuse a single TextDecoder instance to avoid instantiation overhead
// when parsing multiple strings in EXIF metadata.
const asciiDecoder = new TextDecoder("ascii");

/**
 * Extract EXIF data from image file
 * Uses ArrayBuffer reading for JPEG EXIF extraction
 */
async function extractExifData(file) {
  // Only JPEG files have EXIF
  if (!file.type.includes("jpeg") && !file.type.includes("jpg")) {
    return null;
  }

  try {
    const arrayBuffer = await file.arrayBuffer();
    const dataView = new DataView(arrayBuffer);

    // Check for JPEG SOI marker
    if (dataView.getUint16(0) !== 0xffd8) {
      return null;
    }

    // Find EXIF marker (APP1)
    let offset = 2;
    while (offset < dataView.byteLength) {
      const marker = dataView.getUint16(offset);

      if (marker === 0xffe1) {
        // Found APP1 (EXIF)
        const exifData = parseExifSegment(dataView, offset);
        return exifData;
      }

      if ((marker & 0xff00) !== 0xff00) break;

      const length = dataView.getUint16(offset + 2);
      offset += length + 2;
    }

    return null;
  } catch (error) {
    console.warn("EXIF extraction failed:", error);
    return null;
  }
}

/**
 * Parse EXIF segment from DataView
 */
function parseExifSegment(dataView, offset) {
  const exif = {};

  try {
    // segmentLength was defined here but never used. Removed to fix lint error.
    const exifOffset = offset + 4;

    // Check for "Exif\0\0" header
    const exifHeader = String.fromCharCode(
      dataView.getUint8(exifOffset),
      dataView.getUint8(exifOffset + 1),
      dataView.getUint8(exifOffset + 2),
      dataView.getUint8(exifOffset + 3),
    );

    if (exifHeader !== "Exif") {
      return null;
    }

    const tiffOffset = exifOffset + 6;
    const littleEndian = dataView.getUint16(tiffOffset) === 0x4949;

    // Read IFD0 offset
    const ifd0Offset = dataView.getUint32(tiffOffset + 4, littleEndian);
    const ifdStart = tiffOffset + ifd0Offset;

    // Parse IFD entries
    const entryCount = dataView.getUint16(ifdStart, littleEndian);

    for (let i = 0; i < entryCount; i++) {
      const entryOffset = ifdStart + 2 + i * 12;
      const tag = dataView.getUint16(entryOffset, littleEndian);

      // Common EXIF tags
      switch (tag) {
        case 0x010f: // Make (Camera manufacturer)
          exif.camera = readExifString(
            dataView,
            entryOffset,
            tiffOffset,
            littleEndian,
          );
          break;
        case 0x0110: { // Model
          const model = readExifString(
            dataView,
            entryOffset,
            tiffOffset,
            littleEndian,
          );
          exif.camera = exif.camera ? `${exif.camera} ${model}` : model;
          break;
        }
        case 0x0112: // Orientation
          exif.orientation = dataView.getUint16(entryOffset + 8, littleEndian);
          break;
        case 0x9003: // DateTimeOriginal
          exif.dateTaken = readExifString(
            dataView,
            entryOffset,
            tiffOffset,
            littleEndian,
          );
          break;
      }
    }

    return Object.keys(exif).length > 0 ? exif : null;
  } catch (error) {
    console.warn("EXIF parsing error:", error);
    return null;
  }
}

// Global TextDecoder instance for efficient binary-to-string conversion
const textDecoder = new TextDecoder("utf-8");

/**
 * Read string value from EXIF entry
 */
function readExifString(dataView, entryOffset, tiffOffset, littleEndian) {
  try {
    const type = dataView.getUint16(entryOffset + 2, littleEndian);
    const count = dataView.getUint32(entryOffset + 4, littleEndian);

    if (type !== 2) return null; // Type 2 = ASCII string

    let stringOffset;
    if (count <= 4) {
      stringOffset = entryOffset + 8;
    } else {
      stringOffset =
        tiffOffset + dataView.getUint32(entryOffset + 8, littleEndian);
    }

    // ⚡ Bolt: Performance optimization
    // Avoid O(n) string concatenations by using native TextDecoder for binary-to-string conversion.
    // We use Math.max(0, count - 1) to exclude the null terminator.
    const length = Math.max(0, count - 1);
    const bytes = new Uint8Array(
      dataView.buffer,
      dataView.byteOffset + stringOffset,
      length,
    );
    return new TextDecoder().decode(bytes).trim();
    if (count <= 1) return "";

    const bytes = new Uint8Array(
      dataView.buffer,
      dataView.byteOffset + stringOffset,
      count - 1,
    );
    return new TextDecoder("utf-8").decode(bytes).trim();
    // Optimization: Use global TextDecoder on a Uint8Array view instead of manual string concatenation
    // This avoids JS string instantiation overhead per character and is significantly faster for EXIF parsing
    const length = Math.max(0, count - 1);
    const uint8Array = new Uint8Array(
      dataView.buffer,
      dataView.byteOffset + stringOffset,
      length,
    );
    return textDecoder.decode(uint8Array).trim();
    // Optimization: Use global TextDecoder on a Uint8Array view rather than
    // string concatenation loop. This is ~5x faster by avoiding string allocation
    // per character and relying on native string decoding.
    const stringBytes = new Uint8Array(
      dataView.buffer,
      dataView.byteOffset + stringOffset,
      count > 0 ? count - 1 : 0,
    );
    return asciiDecoder.decode(stringBytes).trim();
  } catch {
    return null;
  }
}

/**
 * Create a thumbnail from an image file
 * @param {File} file - The image file
 * @param {number} maxSize - Maximum dimension
 * @param {Object} [dimensions] - Optional known dimensions {width, height} to speed up calculation
 * @returns {Promise<Blob>} Thumbnail blob
 */
export async function createThumbnail(file, maxSize = 200, dimensions = null) {
  // Optimization: Use createImageBitmap if available (modern browsers)
  // This is much faster as it avoids DOM overhead and decoding the full image
  if (typeof createImageBitmap !== "undefined") {
    try {
      let width, height;

      if (dimensions) {
        width = dimensions.width;
        height = dimensions.height;
      } else {
        // If dimensions unknown, get them quickly
        const bitmap = await createImageBitmap(file);
        width = bitmap.width;
        height = bitmap.height;
        bitmap.close();
      }

      // Calculate target dimensions
      let targetWidth = width;
      let targetHeight = height;

      if (width > height) {
        if (width > maxSize) {
          targetHeight = Math.round((height * maxSize) / width);
          targetWidth = maxSize;
        }
      } else {
        if (height > maxSize) {
          targetWidth = Math.round((width * maxSize) / height);
          targetHeight = maxSize;
        }
      }

      // Create resized bitmap directly
      const resizedBitmap = await createImageBitmap(file, {
        resizeWidth: targetWidth,
        resizeHeight: targetHeight,
        resizeQuality: "high",
      });

      // Draw to canvas to get blob
      const canvas = document.createElement("canvas");
      canvas.width = targetWidth;
      canvas.height = targetHeight;
      const ctx = canvas.getContext("2d");
      // Explicitly specify target dimensions to handle browsers that ignore resize options
      ctx.drawImage(resizedBitmap, 0, 0, targetWidth, targetHeight);
      resizedBitmap.close();

      return new Promise((resolve) =>
        canvas.toBlob((blob) => resolve(blob), "image/jpeg", 0.8),
      );
    } catch (e) {
      console.warn("createImageBitmap failed, falling back to Image:", e);
      // Fallback to standard method on error
    }
  }

  // Fallback: Standard Image object approach
  return new Promise((resolve, reject) => {
    const img = new Image();
    const url = URL.createObjectURL(file);

    img.onload = () => {
      URL.revokeObjectURL(url);

      let width = img.naturalWidth;
      let height = img.naturalHeight;

      // Calculate new dimensions
      if (width > height) {
        if (width > maxSize) {
          height = Math.round((height * maxSize) / width);
          width = maxSize;
        }
      } else {
        if (height > maxSize) {
          width = Math.round((width * maxSize) / height);
          height = maxSize;
        }
      }

      // Create canvas and draw
      const canvas = document.createElement("canvas");
      canvas.width = width;
      canvas.height = height;

      const ctx = canvas.getContext("2d");
      ctx.drawImage(img, 0, 0, width, height);

      canvas.toBlob((blob) => resolve(blob), "image/jpeg", 0.8);
    };

    img.onerror = () => {
      URL.revokeObjectURL(url);
      reject(new Error("Failed to create thumbnail"));
    };

    img.src = url;
  });
}

/**
 * Format file size for display
 */
export function formatFileSize(bytes) {
  if (bytes === 0) return "0 B";

  const isNegative = bytes < 0;
  const absBytes = Math.abs(bytes);

  const k = 1024;
  const sizes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

  let i = Math.floor(Math.log(absBytes) / Math.log(k));

  // Ensure index is within bounds of sizes array
  i = Math.min(i, sizes.length - 1);

  let value = absBytes / Math.pow(k, i);

  // If rounding up to 1024, move to next unit
  if (parseFloat(value.toFixed(1)) >= k && i < sizes.length - 1) {
    i++;
    value = value / k;
  }

  const formattedValue = parseFloat(value.toFixed(1));
  return (isNegative ? "-" : "") + formattedValue + " " + sizes[i];
}

/**
 * Get a color-coded indicator for image quality based on dimensions
 */
export function getImageQuality(width, height) {
  const megapixels = (width * height) / 1000000;

  if (megapixels >= 8) return { label: "Excellent", color: "green" };
  if (megapixels >= 4) return { label: "Good", color: "blue" };
  if (megapixels >= 2) return { label: "Fair", color: "yellow" };
  return { label: "Low", color: "red" };
}

export default {
  extractImageMetadata,
  createThumbnail,
  formatFileSize,
  getImageQuality,
};
