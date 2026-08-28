import os

import functions_framework
from google.cloud import firestore, vision
import vertexai
from vertexai.generative_models import GenerativeModel

vision_client = vision.ImageAnnotatorClient()
firestore_client = firestore.Client()

PROJECT_ID = os.environ.get("GCP_PROJECT") or os.environ.get("PROJECT_ID")
vertexai.init(project=PROJECT_ID, location="us-central1")
gemini_model = GenerativeModel("gemini-1.5-flash-002")


def generate_family_story(labels, extracted_text, face_count):
    """Create a short family-history narrative from extracted metadata."""
    prompt = f"""
    You are an expert family historian and storyteller for Aevum, a premium heritage preservation app.
    Given the following metadata from an old family photograph, write a warm, poetic, and brief Family Story (2-3 sentences).

    Metadata:
    - Labels: {", ".join(labels)}
    - Extracted Text: {extracted_text if extracted_text else "None"}
    - People Detected: {face_count}

    Guidelines:
    - Be nostalgic but respectful.
    - If there is text, try to weave it into the context.
    - Make it feel like it belongs in a high-end family archive.
    - Do not claim facts that cannot be inferred from the supplied metadata.
    - Do not use phrases like "Based on the labels" or "The metadata shows".
    """

    try:
        response = gemini_model.generate_content(prompt)
        return response.text.strip()
    except Exception as error:
        print(f"Error generating story: {error}")
        return "A moment preserved in time, waiting for its story to be told."


def firestore_string(fields, key):
    return fields.get(key, {}).get("stringValue")


def firestore_map(fields, key):
    return fields.get(key, {}).get("mapValue", {}).get("fields", {})


def canonical_display_uri(fields):
    """Prefer the canonical preservation field, with migration fallback."""
    storage_fields = firestore_map(fields, "storage")
    canonical = firestore_string(storage_fields, "displayGsUri")
    if canonical:
        return canonical

    legacy_urls = firestore_map(fields, "urls")
    return firestore_string(legacy_urls, "display")


@functions_framework.cloud_event
def analyze_media(cloud_event):
    """Analyze a media_items document after preservation or AI request updates."""
    data = cloud_event.data
    resource_name = data["value"]["name"]
    doc_id = resource_name.split("/")[-1]
    fields = data["value"]["fields"]

    status = firestore_string(fields, "status")
    ai_status = firestore_string(fields, "aiStatus")

    if ai_status == "restoration_pending":
        process_restoration(doc_id, fields)
        return

    if status == "processed" and ai_status == "pending":
        analyze_media_logic(doc_id, fields)
        return

    print(f"Skipping analysis for {doc_id}. Status: {status}, AI Status: {ai_status}")


def process_restoration(doc_id, fields):
    """Handle the current restoration request contract.

    Restoration remains a product prototype; this function only records the
    requested options and completion state until a real restoration model is
    integrated in the dedicated AI hardening workstream.
    """
    print(f"Starting AI Restoration for {doc_id}")
    params = firestore_map(fields, "restorationParams")
    colorize = params.get("colorize", {}).get("booleanValue", False)
    sharpen = params.get("sharpen", {}).get("booleanValue", False)
    repair = params.get("repair", {}).get("booleanValue", False)

    doc_ref = firestore_client.collection("media_items").document(doc_id)
    try:
        print(
            "Restoration prototype options: "
            f"Colorize={colorize}, Sharpen={sharpen}, Repair={repair}"
        )
        doc_ref.update(
            {
                "aiStatus": "restoration_completed",
                "restorationResult": {
                    "completedAt": firestore.SERVER_TIMESTAMP,
                    "applied": {
                        "colorize": colorize,
                        "sharpen": sharpen,
                        "repair": repair,
                    },
                    "prototype": True,
                },
            }
        )
    except Exception as error:
        print(f"Error during restoration: {error}")
        doc_ref.update(
            {
                "aiStatus": "restoration_failed",
                "aiError": str(error)[:1000],
            }
        )


def analyze_media_logic(doc_id, fields):
    display_gs_uri = canonical_display_uri(fields)

    if not display_gs_uri:
        print(f"No preserved display URI found for {doc_id}")
        return

    doc_ref = firestore_client.collection("media_items").document(doc_id)

    try:
        image = vision.Image()
        image.source.image_uri = display_gs_uri

        features = [
            vision.Feature(type_=vision.Feature.Type.FACE_DETECTION),
            vision.Feature(type_=vision.Feature.Type.LABEL_DETECTION),
            vision.Feature(type_=vision.Feature.Type.TEXT_DETECTION),
            vision.Feature(type_=vision.Feature.Type.IMAGE_PROPERTIES),
            vision.Feature(type_=vision.Feature.Type.SAFE_SEARCH_DETECTION),
        ]

        request = vision.AnnotateImageRequest(image=image, features=features)
        response = vision_client.annotate_image(request=request)
        if response.error.message:
            raise RuntimeError(response.error.message)

        labels = [label.description for label in response.label_annotations]
        full_text = (
            response.full_text_annotation.text
            if response.full_text_annotation
            else ""
        )

        detected_faces = [
            {
                "confidence": face.detection_confidence,
                "boundingBox": [
                    {"x": vertex.x, "y": vertex.y}
                    for vertex in face.bounding_poly.vertices
                ],
                "joyLikelihood": face.joy_likelihood.name,
                "headwearLikelihood": face.headwear_likelihood.name,
            }
            for face in response.face_annotations
        ]
        face_count = len(detected_faces)

        safe_search = response.safe_search_annotation
        story = generate_family_story(labels, full_text, face_count)

        doc_ref.set(
            {
                "aiStatus": "completed",
                "story": story,
                "analysis": {
                    "labels": labels,
                    "faceCount": face_count,
                    "detectedFaces": detected_faces,
                    "extractedText": full_text,
                    "safeSearch": {
                        "adult": safe_search.adult.name,
                        "violence": safe_search.violence.name,
                        "racy": safe_search.racy.name,
                        "medical": safe_search.medical.name,
                        "spoof": safe_search.spoof.name,
                    },
                },
                "aiCompletedAt": firestore.SERVER_TIMESTAMP,
            },
            merge=True,
        )

        print(f"AI analysis completed for {doc_id} from {display_gs_uri}")

    except Exception as error:
        print(f"Error during AI analysis: {error}")
        doc_ref.update(
            {
                "aiStatus": "failed",
                "aiError": str(error)[:1000],
                "aiFailedAt": firestore.SERVER_TIMESTAMP,
            }
        )


if __name__ == "__main__":
    pass
