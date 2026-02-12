import os
import functions_framework
from google.cloud import vision, firestore, storage

# Initialize clients
vision_client = vision.ImageAnnotatorClient()
firestore_client = firestore.Client()
storage_client = storage.Client()

@functions_framework.cloud_event
def analyze_media(cloud_event):
    """
    Triggered by a change to a Firestore document.
    Path: projects/{project}/databases/{database}/documents/media_items/{id}
    """
    data = cloud_event.data
    # Extract the document path and ID
    # Gen2 Eventarc format for Firestore
    resource_name = data["value"]["name"]
    doc_id = resource_name.split("/")[-1]
    
    fields = data["value"]["fields"]
    
    # Check if we should process
    # We only process if status is 'processed' (from preservation-processor) 
    # and aiStatus is 'pending'
    status = fields.get("status", {}).get("stringValue")
    ai_status = fields.get("aiStatus", {}).get("stringValue")
    
    if status != "processed" or ai_status != "pending":
        print(f"Skipping analysis for {doc_id}. Status: {status}, AI Status: {ai_status}")
        return

    # Get the image URL (we'll use the 'display' version in the gallery for analysis)
    # This is cheaper than analyzing the RAW/TIFF original.
    display_gs_url = fields.get("urls", {}).get("mapValue", {}).get("fields", {}).get("display", {}).get("stringValue")
    
    if not display_gs_url:
        print(f"Error: No display URL found for {doc_id}")
        return

    print(f"Starting AI Analysis for: {display_gs_url}")

    try:
        # 1. Vision API Analysis
        image = vision.Image()
        image.source.image_uri = display_gs_url

        # Perform multiple detection features in one call
        features = [
            vision.Feature(type_=vision.Feature.Type.FACE_DETECTION),
            vision.Feature(type_=vision.Feature.Type.LABEL_DETECTION),
            vision.Feature(type_=vision.Feature.Type.TEXT_DETECTION),
            vision.Feature(type_=vision.Feature.Type.IMAGE_PROPERTIES),
            vision.Feature(type_=vision.Feature.Type.SAFE_SEARCH_DETECTION)
        ]
        
        request = vision.AnnotateImageRequest(image=image, features=features)
        response = vision_client.annotate_image(request=request)

        # 2. Extract Data
        # A. Labels
        labels = [label.description for label in response.label_annotations]
        
        # B. Faces
        faces = []
        for face in response.face_annotations:
            faces.append({
                'joy': face.joy_likelihood.name,
                'sorrow': face.sorrow_likelihood.name,
                'anger': face.anger_likelihood.name,
                'surprise': face.surprise_likelihood.name,
                'confidence': face.detection_confidence,
                # Bounding box could be stored here if needed
            })

        # C. Text (OCR)
        full_text = response.full_text_annotation.text if response.full_text_annotation else ""

        # D. Dominant Colors
        colors = []
        if response.image_properties_annotation:
            for color in response.image_properties_annotation.dominant_colors.colors[:3]:
                colors.append({
                    'red': color.color.red,
                    'green': color.color.green,
                    'blue': color.color.blue,
                    'score': color.score
                })

        # E. Safe Search
        safe = response.safe_search_annotation
        is_safe = (safe.adult.name in ['VERY_UNLIKELY', 'UNLIKELY'] and 
                   safe.violence.name in ['VERY_UNLIKELY', 'UNLIKELY'])

        # 3. Update Firestore
        doc_ref = firestore_client.collection('media_items').document(doc_id)
        doc_ref.set({
            'aiStatus': 'completed',
            'analysis': {
                'labels': labels,
                'faceCount': len(faces),
                'faces': faces,
                'extractedText': full_text,
                'dominantColors': colors,
                'isSafe': is_safe
            }
        }, merge=True)

        print(f"AI Analysis completed for {doc_id}. Labels: {len(labels)}, Faces: {len(faces)}")

    except Exception as e:
        print(f"Error during AI analysis: {e}")
        doc_ref = firestore_client.collection('media_items').document(doc_id)
        doc_ref.update({'aiStatus': 'failed', 'aiError': str(e)})

if __name__ == "__main__":
    # Local testing logic if needed
    pass
