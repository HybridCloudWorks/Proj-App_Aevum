/**
 * Image metadata extraction utilities.
 */

const asciiDecoder = new TextDecoder("ascii");

export async function extractImageMetadata(file) {
  const metadata = {
    fileName: file.name,
    fileSize: file.size,
    fileType: file.type,
    lastModified: new Date(file.lastModified).toISOString(),
    width: null,
    height: null,
    aspectRatio: null,
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
    gps: {
      latitude: null,
      longitude: null,
      altitude: null,
      locationName: null,
    },
    extractedAt: new Date().toISOString(),
    processingStatus: "pending",
  };

  try {
    const dimensions = await getImageDimensions(file);
    metadata.width = dimensions.width;
    metadata.height = dimensions.height;
    metadata.aspectRatio = (dimensions.width / dimensions.height).toFixed(2);

    const exifData = await extractExifData(file);
    if (exifData) {
      const { gps, ...exifFields } = exifData;
      metadata.exif = { ...metadata.exif, ...exifFields };
      if (gps) metadata.gps = { ...metadata.gps, ...gps };
    }

    metadata.processingStatus = "complete";
  } catch (error) {
    console.error("Error extracting metadata:", error);
    metadata.processingStatus = "error";
    metadata.error = error.message;
  }

  return metadata;
}

function getImageDimensions(file) {
  return new Promise((resolve, reject) => {
    const image = new Image();
    const objectUrl = URL.createObjectURL(file);

    image.onload = () => {
      URL.revokeObjectURL(objectUrl);
      resolve({ width: image.naturalWidth, height: image.naturalHeight });
    };
    image.onerror = () => {
      URL.revokeObjectURL(objectUrl);
      reject(new Error("Failed to load image"));
    };
    image.src = objectUrl;
  });
}

async function extractExifData(file) {
  if (!file.type.includes("jpeg") && !file.type.includes("jpg")) return null;

  try {
    const arrayBuffer = await file.arrayBuffer();
    const dataView = new DataView(arrayBuffer);
    if (dataView.byteLength < 4 || dataView.getUint16(0) !== 0xffd8) return null;

    let offset = 2;
    while (offset + 4 <= dataView.byteLength) {
      const marker = dataView.getUint16(offset);
      if (marker === 0xffe1) return parseExifSegment(dataView, offset);
      if ((marker & 0xff00) !== 0xff00) break;

      const segmentLength = dataView.getUint16(offset + 2);
      if (segmentLength < 2) break;
      offset += segmentLength + 2;
    }
    return null;
  } catch (error) {
    console.warn("EXIF extraction failed:", error);
    return null;
  }
}

function parseExifSegment(dataView, markerOffset) {
  try {
    const exifOffset = markerOffset + 4;
    if (exifOffset + 10 > dataView.byteLength) return null;

    const header = String.fromCharCode(
      dataView.getUint8(exifOffset),
      dataView.getUint8(exifOffset + 1),
      dataView.getUint8(exifOffset + 2),
      dataView.getUint8(exifOffset + 3),
    );
    if (header !== "Exif") return null;

    const tiffOffset = exifOffset + 6;
    const byteOrder = dataView.getUint16(tiffOffset);
    const littleEndian = byteOrder === 0x4949;
    if (!littleEndian && byteOrder !== 0x4d4d) return null;

    const ifd0RelativeOffset = dataView.getUint32(tiffOffset + 4, littleEndian);
    const ifdStart = tiffOffset + ifd0RelativeOffset;
    if (ifdStart + 2 > dataView.byteLength) return null;

    const exif = {};
    const entryCount = dataView.getUint16(ifdStart, littleEndian);

    for (let index = 0; index < entryCount; index += 1) {
      const entryOffset = ifdStart + 2 + index * 12;
      if (entryOffset + 12 > dataView.byteLength) break;

      const tag = dataView.getUint16(entryOffset, littleEndian);
      switch (tag) {
        case 0x010f:
          exif.camera = readExifString(
            dataView,
            entryOffset,
            tiffOffset,
            littleEndian,
          );
          break;
        case 0x0110: {
          const model = readExifString(
            dataView,
            entryOffset,
            tiffOffset,
            littleEndian,
          );
          if (model) exif.camera = exif.camera ? `${exif.camera} ${model}` : model;
          break;
        }
        case 0x0112:
          exif.orientation = dataView.getUint16(entryOffset + 8, littleEndian);
          break;
        case 0x9003:
          exif.dateTaken = readExifString(
            dataView,
            entryOffset,
            tiffOffset,
            littleEndian,
          );
          break;
        default:
          break;
      }
    }

    return Object.keys(exif).length ? exif : null;
  } catch (error) {
    console.warn("EXIF parsing error:", error);
    return null;
  }
}

function readExifString(dataView, entryOffset, tiffOffset, littleEndian) {
  try {
    const type = dataView.getUint16(entryOffset + 2, littleEndian);
    const count = dataView.getUint32(entryOffset + 4, littleEndian);
    if (type !== 2) return null;
    if (count <= 1) return "";

    const stringOffset =
      count <= 4
        ? entryOffset + 8
        : tiffOffset + dataView.getUint32(entryOffset + 8, littleEndian);
    const length = count - 1;
    if (stringOffset < 0 || stringOffset + length > dataView.byteLength) return null;

    const bytes = new Uint8Array(
      dataView.buffer,
      dataView.byteOffset + stringOffset,
      length,
    );
    return asciiDecoder.decode(bytes).trim();
  } catch {
    return null;
  }
}

function targetDimensions(width, height, maxSize) {
  if (width <= maxSize && height <= maxSize) return { width, height };

  if (width >= height) {
    return {
      width: maxSize,
      height: Math.max(1, Math.round((height * maxSize) / width)),
    };
  }

  return {
    width: Math.max(1, Math.round((width * maxSize) / height)),
    height: maxSize,
  };
}

function canvasToBlob(canvas) {
  return new Promise((resolve, reject) => {
    canvas.toBlob(
      (blob) => (blob ? resolve(blob) : reject(new Error("Failed to create thumbnail"))),
      "image/jpeg",
      0.8,
    );
  });
}

export async function createThumbnail(file, maxSize = 200, dimensions = null) {
  if (typeof createImageBitmap !== "undefined") {
    try {
      let sourceDimensions = dimensions;
      if (!sourceDimensions) {
        const bitmap = await createImageBitmap(file);
        sourceDimensions = { width: bitmap.width, height: bitmap.height };
        bitmap.close();
      }

      const target = targetDimensions(
        sourceDimensions.width,
        sourceDimensions.height,
        maxSize,
      );
      const resizedBitmap = await createImageBitmap(file, {
        resizeWidth: target.width,
        resizeHeight: target.height,
        resizeQuality: "high",
      });

      const canvas = document.createElement("canvas");
      canvas.width = target.width;
      canvas.height = target.height;
      const context = canvas.getContext("2d");
      if (!context) {
        resizedBitmap.close();
        throw new Error("Canvas 2D context unavailable");
      }

      context.drawImage(resizedBitmap, 0, 0, target.width, target.height);
      resizedBitmap.close();
      return await canvasToBlob(canvas);
    } catch (error) {
      console.warn("createImageBitmap failed, falling back to Image:", error);
    }
  }

  return new Promise((resolve, reject) => {
    const image = new Image();
    const objectUrl = URL.createObjectURL(file);

    image.onload = () => {
      URL.revokeObjectURL(objectUrl);
      const target = targetDimensions(image.naturalWidth, image.naturalHeight, maxSize);
      const canvas = document.createElement("canvas");
      canvas.width = target.width;
      canvas.height = target.height;
      const context = canvas.getContext("2d");
      if (!context) {
        reject(new Error("Canvas 2D context unavailable"));
        return;
      }

      context.drawImage(image, 0, 0, target.width, target.height);
      canvas.toBlob(
        (blob) => (blob ? resolve(blob) : reject(new Error("Failed to create thumbnail"))),
        "image/jpeg",
        0.8,
      );
    };

    image.onerror = () => {
      URL.revokeObjectURL(objectUrl);
      reject(new Error("Failed to create thumbnail"));
    };
    image.src = objectUrl;
  });
}

export function formatFileSize(bytes) {
  if (bytes === 0) return "0 B";

  const negative = bytes < 0;
  const absoluteBytes = Math.abs(bytes);
  const base = 1024;
  const units = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  let unitIndex = Math.min(
    Math.floor(Math.log(absoluteBytes) / Math.log(base)),
    units.length - 1,
  );
  let value = absoluteBytes / Math.pow(base, unitIndex);

  if (Number(value.toFixed(1)) >= base && unitIndex < units.length - 1) {
    value /= base;
    unitIndex += 1;
  }

  const formatted = Number(value.toFixed(1));
  return `${negative ? "-" : ""}${formatted} ${units[unitIndex]}`;
}

export function getImageQuality(width, height) {
  const megapixels = (width * height) / 1_000_000;
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
