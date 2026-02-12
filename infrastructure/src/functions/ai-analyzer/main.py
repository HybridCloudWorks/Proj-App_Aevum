import os
import functions_framework
from google.cloud import vision, firestore, storage
import vertexai
from vertexai.generative_models import GenerativeModel

# Initialize clients
vision_client = vision.ImageAnnotatorClient()
firestore_client = firestore.Client()
storage_client = storage.Client()

# Initialize Vertex AI for Gemini
PROJECT_ID = os.environ.get('GCP_PROJECT') or os.environ.get('PROJECT_ID')
vertexai.init(project=PROJECT_ID, location="us-central1")
gemini_model = GenerativeModel("gemini-1.5-flash-002")

def generate_family_story(labels, extracted_text, face_count):
    """Uses Gemini to create a narrative from extracted metadata."""
    prompt = f"""
    You are an expert family historian and storyteller for Aevum, a premium heritage preservation app.
    Given the following metadata from an old family photograph, write a warm, poetic, and brief 'Family Story' (2-3 sentences).
    
    Metadata:
    - Labels: {", ".join(labels)}
    - Extracted Text: {extracted_text if extracted_text else "None"}
    - People Detected: {face_count}
    
    Guidelines:
    - Be nostalgic but respectful.
    - If there is text, try to weave it into the context.
    - Make it feel like it belongs in a high-end family archive.
    - Do not use phrases like "Based on the labels" or "The metadata shows".
    """
    
    try:
        response = gemini_model.generate_content(prompt)
        return response.text.strip()
    except Exception as e:
        print(f"Error generating story: {e}")
        return "A moment preserved in time, waiting for its story to be told."

@functions_framework.cloud_event
def analyze_media(cloud_event):
    """
    Triggered by a change to a Firestore document.
    Path: projects/{project}/databases/{database}/documents/media_items/{id}
    """
    data = cloud_event.data
    resource_name = data["value"]["name"]
    doc_id = resource_name.split("/")[-1]
    
    fields = data["value"]["fields"]
    
    status = fields.get("status", {}).get("stringValue")
    ai_status = fields.get("aiStatus", {}).get("stringValue")
    
    if status != "processed" or ai_status != "pending":
        print(f"Skipping analysis for {doc_id}. Status: {status}, AI Status: {ai_status}")
        return

    display_gs_url = fields.get("urls", {}).get("mapValue", {}).get("fields", {}).get("display", {}).get("stringValue")
    
    if not display_gs_url:
        print(f"Error: No display URL found for {doc_id}")
        return

    try:
        # 1. Vision API Analysis
        image = vision.Image()
        image.source.image_uri = display_gs_url

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
        labels = [label.description for label in response.label_annotations]
        full_text = response.full_text_annotation.text if response.full_text_annotation else ""
        face_count = len(response.face_annotations)
        
        # 3. Gemini LLM Enrichment (Generation of the Family Story)
        story = generate_family_story(labels, full_text, face_count)

        # 4. Update Firestore
        doc_ref = firestore_client.collection('media_items').document(doc_id)
        doc_ref.set({
            'aiStatus': 'completed',
            'story': story,
            'analysis': {
                'labels': labels,
                'faceCount': face_count,
                'extractedText': full_text,
                'isSafe': True # Simplified for flow
            }
        }, merge=True)

        print(f"AI Analysis & Story Generation completed for {doc_id}")

    except Exception as e:
        print(f"Error during AI analysis: {e}")
        doc_ref = firestore_client.collection('media_items').document(doc_id)
        doc_ref.update({'aiStatus': 'failed', 'aiError': str(e)})


if __name__ == "__main__":
    # Local testing logic if needed
    pass
