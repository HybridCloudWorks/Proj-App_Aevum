# Aevum Storage & AI Processing Strategy

**Objective**: Scalable, cost-effective photo storage with automated AI processing and rich album features.

## 1. Architecture Overview (Hybrid Cloud)

We leverage **Firebase Storage** (Google Cloud Storage wrapper) for direct mobile ingestion and **Google Cloud Platform (GCP)** services for processing and archival.

### **Core Components:**

1.  **Ingestion Zone (Firebase Storage)**:
    - Bucket: `aevum-uploads-temp` (Temporary holding)
    - Access: Authenticated Users (via Firebase Auth)
    - Trigger: `onFinalize` Cloud Function

2.  **Preservation Standards (The "Digital Negative")**:
    - **Concern**: "Does JPG compress it too much?" -> **YES**.
    - **Strategy**:
      - **Ingest**: Upload **Bit-Perfect Originals** (RAW, TIFF, PNG, HEIC). _Zero_ compression on client.
      - **Archive (Coldline)**: The exact uploaded file is moved to Coldline storage. It is never modified.
      - **Display (Hot/Warm)**: Only _derived_ copies (Thumbnails, Screen-Size) are compressed to WebP/AVIF for fast loading.

3.  **Processing Pipeline (Cloud Functions / Cloud Run)**:
    - **Step 1: Validation & Sanitization**: Check file types, strip dangerous metadata (except EXIF).
    - **Step 2: Optimization (Cost Saver)**:
      - Generate **Thumbnail** (200x200, WebP) - for grids.
      - Generate **Display** (1080p, WebP) - for full-screen viewing.
      - _Originals_ are moved to Coldline/Archive storage if older than 30 days (Lifecycle Policy).
    - **Step 3: AI Analysis (Vertex AI / Vision API)**:
      - Detect Faces (Identity Matcher).
      - Extract Text (OCR for documents/letters).
      - Label Detection (Context: "Wedding", "Beach", "1990s").
      - **LLM Enrichment**: Send context to Gemini for "Story Generation".

4.  **Metadata Layer (Firestore)**:
    - Stores `albums`, `media_items` (linking to Storage URLs), `tags`, `people` (identities).
    - **Cost Optimization**: Store GCS paths (`gs://...`) instead of public URLs to avoid token generation costs until needed.

## 2. Cost Optimization Strategy (The "Cheap" Way)

Storage costs on GCP are primarily driven by **Storage Class** and **Egress**.

### **Tiered Storage Architecture:**

| Tier     | Storage Class | Use Case                                  | Cost (approx/GB/mo) |
| :------- | :------------ | :---------------------------------------- | :------------------ |
| **Hot**  | Standard      | Thumbnails, Recent Uploads, JSON Metadata | ~$0.020             |
| **Warm** | Nearline      | Display Versions (> 30 days old)          | ~$0.010             |
| **Cold** | Coldline      | Original High-Res Files (Backup)          | ~$0.004             |
| **Deep** | Archive       | Restoration Raw Scans (Rare access)       | ~$0.0012            |

**Action Plan:**

1.  Set up **Object Lifecycle Management** rules on the main bucket.
    - _Rule_: "Move objects to Coldline if `age > 30 days` AND `matches_pattern: originals/*`".
2.  **Serve WebP**: Always serve compressed WebP images to the client. Reduces bandwidth (egress) costs by ~30-50% compared to JPEG/PNG.

## 3. Implementation Guide for Agents

### **Role: GDEF (Google Developer Expert - Firebase)**

- **Responsibility**:
  - Configure `storage.rules` for secure user-scoped access (`match /users/{userId}/{allPaths=**}`).
  - Implement Client-side Resizer (Flutter) to upload a small "preview" immediately while the full Res uploads in background.
  - Set up Firestore `media` collection structure.

### **Role: CKAD (Kubernetes App Developer) / Backend**

- **Responsibility**:
  - Deploy **"Librarian" Service** (Cloud Run or K8s Function):
    - Listens to Pub/Sub events from Storage.
    - Executes `imagemagick` or `sharp` for resizing.
    - Calls Vertex AI/Gemini API.
  - **Why Backend?**: Heavy AI processing is cheaper on Cloud Run instances (or Spot instances) than huge Cloud Functions.

## 4. AI Feature Specs ("Great Detail")

### **Auto-Albums (Smart Collections)**

- **Logic**: Group by `location` + `date` + `faces`.
- **Implementation**:
  - Firestore `albums` collection.
  - Cloud Function triggers on `media_item` creation -> Checks if it belongs to an existing "Event Cluster". If yes, add to album. If no, create new "Untitled Event".

### **Semantic Search**

- **User Query**: "Show me photos of Dad in Paris 1990".
- **Mechanism**:
  - Store vector embeddings of images (via CLIP or Multimodal Embeddings) in **Vector Search** (Firebase Extension or Qdrant on VPS).
  - Map query to vector -> Search -> Return Image IDs.
