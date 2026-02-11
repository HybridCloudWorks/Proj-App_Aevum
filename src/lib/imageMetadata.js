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
    const segmentLength = dataView.getUint16(offset + 2);
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
        case 0x0110: // Model
          const model = readExifString(
            dataView,
            entryOffset,
            tiffOffset,
            littleEndian,
          );
          exif.camera = exif.camera ? `${exif.camera} ${model}` : model;
          break;
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

    let str = "";
    for (let i = 0; i < count - 1; i++) {
      str += String.fromCharCode(dataView.getUint8(stringOffset + i));
    }

    return str.trim();
  } catch {
    return null;
  }
}

/**
 * Create a thumbnail from an image file
 * @param {File} file - The image file
 * @param {number} maxSize - Maximum dimension
 * @returns {Promise<Blob>} Thumbnail blob
 */
export async function createThumbnail(file, maxSize = 200) {
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
  const k = 1024;
  const sizes = ["B", "KB", "MB", "GB"];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(1)) + " " + sizes[i];
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
