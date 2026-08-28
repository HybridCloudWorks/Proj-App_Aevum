import io
import os
import tempfile
from pathlib import PurePosixPath

import functions_framework
from google.api_core.exceptions import PreconditionFailed
from google.cloud import firestore, storage
from PIL import ExifTags, Image, ImageOps
from pillow_heif import register_heif_opener

register_heif_opener()

SOURCE_BUCKET = os.environ.get("SOURCE_BUCKET")
ARCHIVE_BUCKET = os.environ.get("ARCHIVE_BUCKET")

storage_client = storage.Client()
firestore_client = firestore.Client()

SUPPORTED_IMAGE_TYPES = {
    "image/jpeg",
    "image/png",
    "image/tiff",
    "image/webp",
    "image/heic",
    "image/heif",
}


def parse_original_path(object_name):
    """Return (family_id, media_id, filename) for canonical original paths."""
    parts = PurePosixPath(object_name).parts
    if len(parts) != 6:
        return None
    if parts[0] != "families" or parts[2] != "media" or parts[4] != "original":
        return None
    return parts[1], parts[3], parts[5]


def rational_to_float(value):
    try:
        return float(value)
    except (TypeError, ValueError, ZeroDivisionError):
        if isinstance(value, tuple) and len(value) == 2 and value[1]:
            return value[0] / value[1]
        raise


def dms_to_decimal(values, reference):
    degrees, minutes, seconds = [rational_to_float(value) for value in values]
    decimal = degrees + minutes / 60.0 + seconds / 3600.0
    return -decimal if reference in {"S", "W"} else decimal


def extract_exif(image):
    """Extract a conservative subset of preservation metadata."""
    result = {}
    try:
        exif = image.getexif()
        if not exif:
            return result

        decoded = {ExifTags.TAGS.get(tag, tag): value for tag, value in exif.items()}
        result["dateTaken"] = decoded.get("DateTimeOriginal") or decoded.get("DateTime")
        result["cameraMake"] = str(decoded.get("Make") or "") or None
        result["cameraModel"] = str(decoded.get("Model") or "") or None
        result["orientation"] = decoded.get("Orientation")

        gps_ifd = None
        if hasattr(exif, "get_ifd"):
            try:
                gps_ifd = exif.get_ifd(0x8825)
            except (KeyError, TypeError, ValueError):
                gps_ifd = None

        if gps_ifd:
            gps = {ExifTags.GPSTAGS.get(tag, tag): value for tag, value in gps_ifd.items()}
            if all(
                key in gps
                for key in (
                    "GPSLatitude",
                    "GPSLatitudeRef",
                    "GPSLongitude",
                    "GPSLongitudeRef",
                )
            ):
                result["location"] = {
                    "latitude": dms_to_decimal(gps["GPSLatitude"], gps["GPSLatitudeRef"]),
                    "longitude": dms_to_decimal(
                        gps["GPSLongitude"], gps["GPSLongitudeRef"]
                    ),
                }
    except Exception as error:  # Metadata must never prevent preservation.
        print(f"EXIF extraction warning: {error}")

    return result


def upload_if_absent(bucket, path, stream, content_type):
    """Create an immutable derivative once; retries reuse the existing object."""
    stream.seek(0)
    blob = bucket.blob(path)
    try:
        blob.upload_from_file(
            stream,
            content_type=content_type,
            if_generation_match=0,
        )
        print(f"Created derivative: gs://{bucket.name}/{path}")
    except PreconditionFailed:
        print(f"Derivative already exists: gs://{bucket.name}/{path}")
    return blob


def archive_original(source_bucket, source_blob, archive_bucket, archive_path, generation):
    """Copy the exact source generation to the archive exactly once."""
    try:
        source_bucket.copy_blob(
            source_blob,
            archive_bucket,
            new_name=archive_path,
            source_generation=int(generation),
            if_source_generation_match=int(generation),
            if_generation_match=0,
        )
        print(f"Archived original: gs://{archive_bucket.name}/{archive_path}")
    except PreconditionFailed:
        print(f"Archive object already exists: gs://{archive_bucket.name}/{archive_path}")


@functions_framework.cloud_event
def process_upload(cloud_event):
    """Preserve one canonical family media original and create derivatives."""
    data = cloud_event.data
    bucket_name = data.get("bucket")
    object_name = data.get("name")
    generation = str(data.get("generation") or "0")
    event_id = cloud_event.get("id")

    if not object_name or not bucket_name:
        print("Ignoring event without bucket/object name")
        return

    if SOURCE_BUCKET and bucket_name != SOURCE_BUCKET:
        print(f"Ignoring object from unexpected bucket: {bucket_name}")
        return

    parsed = parse_original_path(object_name)
    if not parsed:
        # Derived/profile/member objects share the bucket and must not recurse.
        print(f"Ignoring non-canonical-original object: {object_name}")
        return

    family_id, media_id, file_name = parsed
    media_ref = firestore_client.collection("media_items").document(media_id)
    media_snapshot = media_ref.get()

    if not media_snapshot.exists:
        print(f"Orphan original has no media_items/{media_id}; leaving object untouched")
        return

    media = media_snapshot.to_dict() or {}
    if media.get("familyId") != family_id:
        print(
            f"Family mismatch for media {media_id}: path={family_id}, "
            f"document={media.get('familyId')}"
        )
        return

    status = media.get("status")
    processing = media.get("processing") or {}
    if status == "upload_failed":
        print(f"Ignoring failed upload media {media_id}")
        return

    if status == "processed" and str(processing.get("sourceGeneration")) == generation:
        print(f"Media {media_id} generation {generation} already processed")
        return

    if status == "uploading":
        # Storage finalization can race the client's Firestore finalization.
        # Raising allows Eventarc retry policy to revisit after status=uploaded.
        raise RuntimeError(f"Media {media_id} upload metadata is not finalized yet")

    source_bucket = storage_client.bucket(bucket_name)
    source_blob = source_bucket.blob(object_name, generation=int(generation))
    content_type = data.get("contentType") or source_blob.content_type

    if content_type and content_type not in SUPPORTED_IMAGE_TYPES:
        media_ref.update(
            {
                "status": "processing_failed",
                "processingError": f"Unsupported preservation type: {content_type}",
                "updatedAt": firestore.SERVER_TIMESTAMP,
            }
        )
        return

    media_ref.update(
        {
            "status": "processing",
            "processing.sourceGeneration": generation,
            "processing.eventId": event_id,
            "processing.startedAt": firestore.SERVER_TIMESTAMP,
            "updatedAt": firestore.SERVER_TIMESTAMP,
        }
    )

    fd, local_path = tempfile.mkstemp(suffix=os.path.splitext(file_name)[1] or ".img")
    os.close(fd)

    try:
        source_blob.download_to_filename(local_path)

        with Image.open(local_path) as opened_image:
            exif = extract_exif(opened_image)
            original_width, original_height = opened_image.size
            normalized = ImageOps.exif_transpose(opened_image).convert("RGB")

            display = normalized.copy()
            display.thumbnail((1920, 1920), Image.Resampling.LANCZOS)
            display_width, display_height = display.size
            display_io = io.BytesIO()
            display.save(display_io, format="WEBP", quality=85, method=6)

            thumbnail = display.copy()
            thumbnail.thumbnail((200, 200), Image.Resampling.LANCZOS)
            thumbnail_io = io.BytesIO()
            thumbnail.save(thumbnail_io, format="WEBP", quality=80, method=6)

        derived_prefix = (
            f"families/{family_id}/media/{media_id}/derived/{generation}"
        )
        display_path = f"{derived_prefix}/display.webp"
        thumbnail_path = f"{derived_prefix}/thumbnail.webp"

        upload_if_absent(source_bucket, display_path, display_io, "image/webp")
        upload_if_absent(source_bucket, thumbnail_path, thumbnail_io, "image/webp")

        if not ARCHIVE_BUCKET:
            raise RuntimeError("ARCHIVE_BUCKET is not configured")
        archive_bucket = storage_client.bucket(ARCHIVE_BUCKET)
        archive_path = (
            f"families/{family_id}/media/{media_id}/originals/"
            f"{generation}/{file_name}"
        )
        archive_original(
            source_bucket,
            source_blob,
            archive_bucket,
            archive_path,
            generation,
        )

        update = {
            "status": "processed",
            "aiStatus": "pending",
            "storage.originalPath": object_name,
            "storage.originalGsUri": f"gs://{bucket_name}/{object_name}",
            "storage.displayPath": display_path,
            "storage.displayGsUri": f"gs://{bucket_name}/{display_path}",
            "storage.thumbnailPath": thumbnail_path,
            "storage.thumbnailGsUri": f"gs://{bucket_name}/{thumbnail_path}",
            "storage.archiveGsUri": f"gs://{ARCHIVE_BUCKET}/{archive_path}",
            "processing.sourceGeneration": generation,
            "processing.completedAt": firestore.SERVER_TIMESTAMP,
            "processing.originalDimensions": {
                "width": original_width,
                "height": original_height,
            },
            "processing.displayDimensions": {
                "width": display_width,
                "height": display_height,
            },
            "processedAt": firestore.SERVER_TIMESTAMP,
            "updatedAt": firestore.SERVER_TIMESTAMP,
        }
        if exif.get("dateTaken"):
            update["processing.dateTaken"] = exif["dateTaken"]
        if exif.get("cameraMake"):
            update["processing.cameraMake"] = exif["cameraMake"]
        if exif.get("cameraModel"):
            update["processing.cameraModel"] = exif["cameraModel"]
        if exif.get("location"):
            update["processing.location"] = exif["location"]

        media_ref.update(update)
        print(f"Preservation completed for media_items/{media_id}")

    except Exception as error:
        print(f"Preservation failed for {media_id}: {error}")
        media_ref.update(
            {
                "status": "processing_failed",
                "processingError": str(error)[:1000],
                "processing.failedAt": firestore.SERVER_TIMESTAMP,
                "updatedAt": firestore.SERVER_TIMESTAMP,
            }
        )
        raise
    finally:
        if os.path.exists(local_path):
            os.remove(local_path)
