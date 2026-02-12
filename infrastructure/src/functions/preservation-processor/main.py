import os
import io
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
    
    # 1. Download Original
    content = blob.download_as_bytes()
    original_image = Image.open(io.BytesIO(content))
    
    # Use existing UUID logic from path: uploads/{userId}/{year}/{month}/{category}/{uuid}.ext
    # Extract UUID and metadata if stored in customMetadata
    metadata = blob.metadata or {}
    media_uuid = metadata.get('uuid') or file_name.split('/')[-1].split('.')[0]
    user_id = metadata.get('uploadedBy') or 'unknown'

    print(f"Identified Media UUID: {media_uuid} for User: {user_id}")

    # 2. Generate Optimized WebP Versions
    # A. Thumbnail (200x200)
    thumb_io = io.BytesIO()
    thumb_img = original_image.copy()
    thumb_img.thumbnail((200, 200))
    thumb_img.save(thumb_io, format='WEBP', quality=80)
    thumb_io.seek(0)

    # B. Display (1080p width, dynamic height)
    display_io = io.BytesIO()
    display_img = original_image.copy()
    if display_img.width > 1920:
        display_img.thumbnail((1920, 1920)) # Maintain aspect ratio
    display_img.save(display_io, format='WEBP', quality=85)
    display_io.seek(0)

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

    # 5. Update Firestore Metadata
    # Update media_items/{media_uuid}
    doc_ref = firestore_client.collection('media_items').document(media_uuid)
    doc_ref.set({
        'status': 'processed',
        'urls': {
            'thumbnail': f"gs://{GALLERY_BUCKET}/{thumb_path}",
            'display': f"gs://{GALLERY_BUCKET}/{display_path}",
            'archive': f"gs://{ARCHIVE_BUCKET}/{file_name}"
        },
        'dimensions': {
            'original': f"{original_image.width}x{original_image.height}",
            'display': f"{display_img.width}x{display_img.height}"
        },
        'processedAt': firestore.SERVER_TIMESTAMP
    }, merge=True)

    print(f"Updated Firestore document: {media_uuid}")
