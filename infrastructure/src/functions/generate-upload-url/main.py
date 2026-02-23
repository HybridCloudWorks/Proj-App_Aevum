from google.cloud import storage
import datetime
import os
import functions_framework
import uuid

BUCKET_NAME = os.environ.get('TEMP_BUCKET', 'aevum-uploads-temp')

@functions_framework.http
def generate_upload_url(request):
    """
    Generates a V4 Signed URL for uploading a file to GCS.

    POST body:
    {
        "contentType": "image/jpeg",
        "userId": "uid_123",
        "familyId": "fam_456"
    }
    """

    # 1. CORS Headers
    if request.method == 'OPTIONS':
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization',
            'Access-Control-Max-Age': '3600'
        }
        return ('', 204, headers)

    headers = {
        'Access-Control-Allow-Origin': '*'
    }

    # 2. Parse Request
    try:
        data = request.get_json()
        content_type = data.get('contentType')
        user_id = data.get('userId')
        family_id = data.get('familyId')

        if not all([content_type, user_id, family_id]):
            return ({'error': 'Missing required fields'}, 400, headers)

        # 3. Validation Logic (Mock)
        # Check if user is in family...

        # 4. Generate Path
        file_uuid = str(uuid.uuid4())
        ext = content_type.split('/')[-1]
        blob_name = f"uploads/{family_id}/{user_id}/{file_uuid}.{ext}"

        storage_client = storage.Client()
        bucket = storage_client.bucket(BUCKET_NAME)
        blob = bucket.blob(blob_name)

        # 5. Generate Signed URL
        url = blob.generate_signed_url(
            version="v4",
            expiration=datetime.timedelta(minutes=15),
            method="PUT",
            content_type=content_type,
            headers={"x-goog-meta-userId": user_id, "x-goog-meta-familyId": family_id}
        )

        return ({
            'url': url,
            'path': blob_name,
            'fileId': file_uuid
        }, 200, headers)

    except Exception as e:
        print(f"Error generating signed URL: {e}")
        return ({'error': 'Internal Server Error'}, 500, headers)
