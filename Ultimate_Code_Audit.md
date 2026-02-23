# 🏆 Ultimate Code Audit: Aevum Media Architecture

**Date:** February 13, 2026
**Auditor:** Elite Code Strategist (Backend Architecture & Scalability Specialist)
**Scope:** Frontend-Backend Integration, Cloud Infrastructure, and Data Security

---

## Phase 1: The Devil’s Advocate (Attack)
*Role: Skeptical Senior Engineer. "Trust nothing. Break everything."*

### 1. The "Split-Brain" Architecture
**Verdict:** 🔴 **Critical Failure**
The codebase suffers from a fundamental identity crisis. The frontend attempts to be a "smart client" (doing heavy lifting) while the backend infrastructure is designed for a "dumb client" (serverless processing), resulting in a broken, redundant, and expensive system.

*   **Evidence:**
    *   **Frontend Overreach:** `apps/web/src/lib/storage.js` imports `imageMetadata.js` to perform client-side EXIF extraction and `canvas`-based thumbnail generation. This burns user battery, relies on browser-specific rendering quirks, and slows down the upload UX.
    *   **Backend Ghost Town:** The `preservation-processor` Cloud Function (`infrastructure/src/functions/preservation-processor`) is designed to do *exactly* the same thing (EXIF, Thumbnails) but is triggered by uploads to an `uploads-temp` bucket.
    *   **The Disconnect:** The frontend uploads **directly** to `families/{familyId}/memories/` (the final destination), completely bypassing the `uploads-temp` bucket.
    *   **Result:** The serverless backend **NEVER RUNS**. The sophisticated Python processing pipeline is dead code. The "AI Analyzer" (`ai-analyzer`) which depends on the processor's output (`status: processed`) is permanently starved of work.

### 2. Security Theatre
**Verdict:** 🔴 **Critical Vulnerability**
The security model is wide open, relying on "security by obscurity" and trusting client-side inputs.

*   **Bypassing the Gatekeeper:** `firestore.rules` allows *any* authenticated user to create a document in `media_items` as long as they claim it's theirs (`request.resource.data.userId == request.auth.uid`). A malicious user can flood the database with fake media records, bypassing any backend validation or processing.
*   **Missing Bucket Protection:** The `storage.rules` file defines rules for `families/{familyId}/media/**`. The frontend uploads to `families/{familyId}/memories/**`. Unless there is a hidden catch-all, these uploads should fail. If they succeed, it implies a misconfigured "allow all" default or admin-privilege leakage in the client.
*   **Trusting Client Metadata:** The backend (if it ran) blindly trusts `blob.metadata` for critical fields like `uuid` and `uploadedBy`. A savvy attacker could overwrite another user's file metadata by guessing their UUIDs.

### 3. Implementation Incompetence
**Verdict:** 🟠 **Major Defect**
Basic coding standards and integration logic are broken.

*   **Phantom Functions:** The `useMemories` hook (`apps/web/src/hooks/useMemories.js`) attempts to import `createMemory` from `@lib/firestore`. **This function does not exist.** The file exports `createMediaItem`. The application's core feature (uploading a memory) effectively crashes or fails silently.
*   **Race Conditions:** The frontend writes metadata to Firestore (`createMemory` logic) *and* the backend is supposed to write metadata (`preservation-processor`). Since they generate different IDs (client-side random vs. server-side UUID), you will end up with **duplicate records** for every photo—one "dumb" record from the client, and one "smart" record from the server (if it ever ran).

---

## Phase 2: The Deeper Lens (Counter-Review)
*Role: Strategic Reviewer. "Look for the nuance. Optimizing for cost vs. UX."*

### 1. The Case for Client-Side Processing
*Counter-point to "Split-Brain":*
While the implementation is disjointed, the *intent* of client-side processing isn't entirely wrong.
*   **Cost Savings:** Generating a 20KB thumbnail on the client and uploading *that* saves significant bandwidth and storage compared to uploading a 50MB RAW file to a temp bucket, processing it, and then storing the result.
*   **UX Latency:** Users want immediate feedback. Waiting for a "cold start" Cloud Function (3-5s) + processing (2-10s) + Firestore update to see their photo appear is a poor experience. The "Optimistic UI" approach (show local preview immediately) is valid.
*   **Strategy:** The flaw isn't *doing* client work; it's *duplicating* it without a handshake.

### 2. The Serverless Trap
*Counter-point to "Backend Ghost Town":*
The current Python backend implementation is naive and dangerous.
*   **Memory Bomb:** `blob.download_as_bytes()` loads the *entire* image into RAM. A 50MB image decompressed into a pixel buffer (RGBA) can easily exceed 500MB. The configured 512MB limit for the Cloud Function guarantees Out-Of-Memory (OOM) crashes on high-res uploads.
*   **Cost Spiral:** The `ai-analyzer` triggers on *every* `media_items` update. Without a "credit system" or throttling, a user uploading 1,000 photos will instantly trigger 1,000 Cloud Function invocations + 1,000 Vision API calls + 1,000 Vertex AI calls. This is a wallet-draining architecture.

---

## Phase 3: Synthesis & Best-in-Class Recommendations
*Role: Elite Code Strategist. "The Path Forward."*

### 1. Adopt the "Signed URL" Ingestion Pattern
**Goal:** Secure, validated uploads without exposing the bucket directly.

*   **Recommendation:**
    1.  **Client:** Requests a "Upload URL" from a Callable Cloud Function (`generateUploadUrl`).
    2.  **Server:** Validates user quota, file type, and permissions. Generates a **Signed URL** for the `uploads-temp` bucket with a specific filename (`uuid`) and short expiration (15 min).
    3.  **Client:** Uploads directly to the Signed URL (bypassing complex Storage Rules).
    4.  **Result:** Solves the security gap (backend controls *who* can upload *where*) and enforces the "Temp Bucket" flow.

### 2. Implement "Smart Hybrid" Processing
**Goal:** Instant UX with robust backend truth.

*   **Recommendation:**
    1.  **Client:**
        *   Generates a very small *blurhash* or low-res placeholder immediately.
        *   Uploads the *original* to the Signed URL.
        *   Writes a "pending" document to Firestore with the `blurhash` for immediate display.
    2.  **Backend (Cloud Function):**
        *   Triggered by `uploads-temp`.
        *   **Stream-processes** the image (using `shutil.copyfileobj` or chunked reading) to avoid OOM.
        *   Generates the official high-quality WebP display versions.
        *   Updates the Firestore doc with the final URLs and sets `status: processed`.
    3.  **Result:** Best of both worlds—fast UI, reliable/verified data.

### 3. Fix the "Broken Code" & Dependencies
**Goal:** Stability and Maintainability.

*   **Action Plan:**
    *   **Rename** `createMediaItem` to `createMemory` in `apps/web/src/lib/firestore.js` (or update the import) to fix the crash.
    *   **Pin Dependencies:** Update `requirements.txt` to use pinned versions (e.g., `google-cloud-storage==2.14.0`) to prevent "it worked yesterday" bugs.
    *   **Rate Limit AI:** Modify `ai-analyzer` to check a `user_credits` balance in Firestore before calling Vertex AI.

### 4. Code Sample: Robust Streaming Processor (Python)
Replace the memory-unsafe `download_as_bytes` with this pattern:

```python
from google.cloud import storage
import io

def process_stream(blob):
    # Open blob as a stream
    with blob.open("rb") as f:
        # Identify image without loading full data
        with Image.open(f) as img:
            img.verify()  # Fast check

            # Re-open for processing (verify closes the file)
            f.seek(0)
            with Image.open(f) as valid_img:
                # Resize logic here (PIL loads lazily)
                # ...
```

### 5. Final Architecture Diagram

```mermaid
graph TD
    Client[Web/Mobile Client] -->|1. Request Upload URL| AuthFunc[Auth Cloud Function]
    AuthFunc -->|2. Return Signed URL| Client
    Client -->|3. Upload Raw File| TempBucket[GCS: uploads-temp]
    Client -->|4. Create Pending Doc (Blurhash)| Firestore
    TempBucket -->|5. Trigger| Processor[Cloud Function: Preservation]
    Processor -->|6. Stream & Optimize| Processor
    Processor -->|7. Save WebP| GalleryBucket[GCS: gallery]
    Processor -->|8. Archive Original| ArchiveBucket[GCS: archive]
    Processor -->|9. Update Doc (Status: Complete)| Firestore
    Firestore -->|10. Trigger (If Credits > 0)| AI[Cloud Function: AI Analyzer]
```
