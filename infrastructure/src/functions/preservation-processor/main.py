import os
import io
import tempfile
import functions_framework
from google.cloud import storage, firestore
from PIL import Image, ImageOps

# Config - could be moved to env vars
TEMP_BUCKET = os.environ.get('TEMP_BUCKET', 'aevum-uploads-temp')
ARCHIVE_BUCKET = os.environ.get('ARCHIVE_BUCKET', 'aevum-archive')
GALLERY_BUCKET = os.environ.get('GALLERY_BUCKET', 'aevum-gallery')

storage_client = storage.Client()
firestore_client = firestore.Client()

@functions_framework.cloud_event
def process_upload(cloud_event):
    """Event-driven function triggered by GCS upload."""
    data = cloud_event.data
    event_id = cloud_event["id"]
    event_type = cloud_event["type"]

    bucket_name = data["bucket"]
    file_name = data["name"]

    print(f"Processing file: {file_name} from bucket: {bucket_name}")

    if not file_name:
        print("No file name provided.")
        return

    # Check file extension or content-type
    ext = file_name.split('.')[-1].lower()
    if ext not in ['jpg', 'jpeg', 'png', 'tiff', 'tif', 'heic', 'raw']:
        print(f"Skipping non-image file: {file_name}")
        return

    temp_bucket = storage_client.bucket(bucket_name)
    blob = temp_bucket.blob(file_name)
    
    # 1. Download Original to Disk to avoid keeping full-res raw file bytes in RAM
    fd, temp_local_filename = tempfile.mkstemp(suffix=".tmp")
    os.close(fd) # Close the OS file handle immediately to prevent leaks
    
    original_image = None
    try:
        blob.download_to_filename(temp_local_filename)
        original_image = Image.open(temp_local_filename)

        # Use existing UUID logic from path: uploads/{userId}/{year}/{month}/{category}/{uuid}.ext
        # Extract UUID and metadata if stored in customMetadata
        metadata = blob.metadata or {}
        media_uuid = metadata.get('uuid') or file_name.split('/')[-1].split('.')[0]
        user_id = metadata.get('uploadedBy') or 'unknown'

        print(f"Identified Media UUID: {media_uuid} for User: {user_id}")

        # Capture original metadata before modification
        original_width, original_height = original_image.size

        # 5. Extract EXIF Data (moved up before resizing)
        exif_data = {}
        try:
            exif = original_image._getexif()
            if exif:
                from PIL.ExifTags import TAGS, GPSTAGS
                for tag, value in exif.items():
                    decoded = TAGS.get(tag, tag)
                    if decoded == "GPSInfo":
                        gps_data = {}
                        for t in value:
                            sub_decoded = GPSTAGS.get(t, t)
                            gps_data[sub_decoded] = value[t]
                        exif_data["gps"] = gps_data
                    else:
                        exif_data[decoded] = str(value)
        except Exception as e:
            print(f"Error extracting EXIF: {e}")

        # 2. Generate Optimized WebP Versions
        # B. Display (1080p width, dynamic height) - Generated first to avoid copies
        display_io = io.BytesIO()
        if original_image.width > 1920:
            original_image.thumbnail((1920, 1920)) # Maintain aspect ratio
        original_image.save(display_io, format='WEBP', quality=85)
        display_io.seek(0)
        display_width, display_height = original_image.size

        # A. Thumbnail (200x200) - Generated from the already resized image
        thumb_io = io.BytesIO()
        original_image.thumbnail((200, 200))
        original_image.save(thumb_io, format='WEBP', quality=80)
        thumb_io.seek(0)

        # 3. Upload Optimized Versions to Gallery Bucket
        gallery_bucket_ref = storage_client.bucket(GALLERY_BUCKET)

        # Path: gallery/{userId}/{uuid}/thumbnail.webp
        thumb_path = f"gallery/{user_id}/{media_uuid}/thumbnail.webp"
        thumb_blob = gallery_bucket_ref.blob(thumb_path)
        thumb_blob.upload_from_file(thumb_io, content_type='image/webp')

        # Path: gallery/{userId}/{uuid}/display.webp
        display_path = f"gallery/{user_id}/{media_uuid}/display.webp"
        display_blob = gallery_bucket_ref.blob(display_path)
        display_blob.upload_from_file(display_io, content_type='image/webp')

        print(f"Uploaded optimized versions to {GALLERY_BUCKET}")

        # 4. Move Original to Archive Bucket (Coldline)
        archive_bucket_ref = storage_client.bucket(ARCHIVE_BUCKET)

        # Path: archive/{userId}/{year}/... same path as temp
        archive_blob = temp_bucket.copy_blob(blob, archive_bucket_ref, file_name)

        if archive_blob.exists():
            print(f"Moved original to Archive: {ARCHIVE_BUCKET}/{file_name}")
            # Delete from Temp
            blob.delete()
        else:
            print("Failed to copy to Archive bucket.")
            return

        # Helper to convert GPS to decimal
        def get_decimal_from_dms(dms, ref):
            degrees = dms[0]
            minutes = dms[1]
            seconds = dms[2]
            decimal = degrees + (minutes / 60.0) + (seconds / 3600.0)
            if ref in ['S', 'W']:
                decimal = -decimal
            return decimal

        lat = None
        lng = None
        if "gps" in exif_data:
            try:
                gps = exif_data["gps"]
                lat = get_decimal_from_dms(gps["GPSLatitude"], gps["GPSLatitudeRef"])
                lng = get_decimal_from_dms(gps["GPSLongitude"], gps["GPSLongitudeRef"])
            except:
                pass

        # 6. Update Firestore Metadata
        doc_ref = firestore_client.collection('media_items').document(media_uuid)
        doc_ref.set({
            'status': 'processed',
            'urls': {
                'thumbnail': f"gs://{GALLERY_BUCKET}/{thumb_path}",
                'display': f"gs://{GALLERY_BUCKET}/{display_path}",
                'archive': f"gs://{ARCHIVE_BUCKET}/{file_name}"
            },
            'dimensions': {
                'original': f"{original_width}x{original_height}",
                'display': f"{display_width}x{display_height}"
            },
            'location': {
                'latitude': lat,
                'longitude': lng
            } if lat and lng else None,
            'takenAt': exif_data.get('DateTimeOriginal') or exif_data.get('DateTime'),
            'aiStatus': 'pending',
            'processedAt': firestore.SERVER_TIMESTAMP
        }, merge=True)

        print(f"Updated Firestore document: {media_uuid} with location: {lat}, {lng}")

    finally:
        # Cleanup local file to prevent storage leaks
        if original_image is not None:
            original_image.close()
        if os.path.exists(temp_local_filename):
            os.remove(temp_local_filename)
