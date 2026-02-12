# Aevum Infrastructure

This directory contains the **Infrastructure as Code (IaC)** for the Aevum platform, using **Terraform** to manage Google Cloud Platform (GCP) resources.

## 🏗️ Architecture Layers

The infrastructure is deployed in strict **dependency order**:

1.  **Data Layer** (`infrastructure/data/terraform/`)
    - **Buckets**: Ingestion (Temp), Archive (Coldline), Gallery (Standard).
    - **Databases**: Firestore (if managed via Terraform).
    - _Why first?_ Compute resources need these buckets to exist before they can write to them.

2.  **Computeless Layer** (`infrastructure/computeless/terraform/`)
    - **Cloud Functions**: Event-driven serverless functions (e.g., `preservation-processor`).
    - **IAM**: Service accounts and permissions.
    - _Why second?_ Functions rely on bucket events (triggers) and access policies defined in the Data layer.

3.  **Compute Layer** (`infrastructure/compute/terraform/`) _(Future)_
    - **Cloud Run / K8s**: Long-running services for heavy AI processing or API hosting.

---

## 🚀 Deployment Guide

**Prerequisites:**

- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and authenticated (`gcloud auth login`).
- [Terraform](https://developer.hashicorp.com/terraform/install) installed.
- A GCP Project ID.

### Step 1: Deploy Data Layer

```bash
cd infrastructure/data/terraform
terraform init
terraform apply -var="project_id=YOUR_PROJECT_ID"
```

### Step 2: Deploy Computeless Layer

```bash
cd ../../computeless/terraform
terraform init
terraform apply -var="project_id=YOUR_PROJECT_ID"
```

---

## 📂 Source Code (`src/`)

- **`functions/preservation-processor/`**: Python code for the `preservation-processor` Cloud Function.
  - **Trigger**: `google.cloud.storage.object.v1.finalized` on `uploads-temp` bucket.
  - **Action**: Validation -> Preservation (Archive) -> Optimization (Gallery) -> Metadata (Firestore).
- **`functions/ai-analyzer/`** _(Coming Soon)_:
  - **Trigger**: Firestore `onCreate` or Pub/Sub.
  - **Action**: Vertex AI Labeling -> Face Detection -> LLM Story Generation.
