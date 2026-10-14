terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  # Partial backend configuration. Supply bucket/prefix per environment during
  # terraform init; CI uses -backend=false for static validation.
  backend "gcs" {}

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.6"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.8.0"
    }
  }
}

variable "project_id" {
  description = "GCP/Firebase project ID"
  type        = string
}

variable "region" {
  description = "GCP region. The Firebase Storage bucket used for Eventarc must be compatible with this trigger region."
  type        = string
  default     = "us-central1"
}

variable "firebase_storage_bucket" {
  description = "Firebase Storage bucket written by Aevum clients."
  type        = string
}

variable "gemini_model" {
  description = "GA Gemini model used for family-story enrichment."
  type        = string
  default     = "gemini-3.5-flash"
}

variable "gemini_location" {
  description = "Gemini Enterprise Agent Platform location. Global is supported by Gemini 3.5 Flash."
  type        = string
  default     = "global"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Existing buckets created by infrastructure/data/terraform.
# uploads_temp is build-source staging only; it is not client-facing.
data "google_storage_bucket" "uploads_temp" {
  name = "${var.project_id}-uploads-temp"
}

data "google_storage_bucket" "archive" {
  name = "${var.project_id}-archive"
}

# Firebase Storage is the canonical client upload front door and derivative store.
data "google_storage_bucket" "firebase_media" {
  name = var.firebase_storage_bucket
}

data "google_storage_project_service_account" "gcs" {
  project = var.project_id
}

resource "google_project_service" "apis" {
  for_each = toset([
    "run.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudbuild.googleapis.com",
    "eventarc.googleapis.com",
    "artifactregistry.googleapis.com",
    "pubsub.googleapis.com",
    "vision.googleapis.com",
    "aiplatform.googleapis.com"
  ])

  service            = each.key
  disable_on_destroy = false
}

resource "google_service_account" "preservation_sa" {
  account_id   = "aevum-preservation-sa"
  display_name = "Aevum preservation processor"
}

resource "google_service_account" "ai_sa" {
  account_id   = "aevum-ai-analyzer-sa"
  display_name = "Aevum AI analyzer"
}

# Direct Cloud Storage Eventarc events require the Google-managed GCS service
# account to publish into Pub/Sub.
resource "google_project_iam_member" "gcs_pubsub_publisher" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${data.google_storage_project_service_account.gcs.email_address}"
}

# Both function identities receive only the delivery/runtime permissions common
# to their own Eventarc-triggered Cloud Run services.
resource "google_project_iam_member" "preservation_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.preservation_sa.email}"
}

resource "google_project_iam_member" "preservation_event_receiver" {
  project = var.project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.preservation_sa.email}"
}

resource "google_project_iam_member" "ai_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.ai_sa.email}"
}

resource "google_project_iam_member" "ai_event_receiver" {
  project = var.project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.ai_sa.email}"
}

# Preservation reads originals, writes immutable derivatives, and writes archive
# copies. It has no Vertex/Gen AI permission.
resource "google_storage_bucket_iam_member" "preservation_media_viewer" {
  bucket = data.google_storage_bucket.firebase_media.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.preservation_sa.email}"
}

resource "google_storage_bucket_iam_member" "preservation_media_creator" {
  bucket = data.google_storage_bucket.firebase_media.name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${google_service_account.preservation_sa.email}"
}

resource "google_storage_bucket_iam_member" "preservation_archive_creator" {
  bucket = data.google_storage_bucket.archive.name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${google_service_account.preservation_sa.email}"
}

resource "google_project_iam_member" "preservation_firestore_user" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.preservation_sa.email}"
}

# AI reads derivatives and updates Firestore. It cannot create/delete media or
# archive objects.
resource "google_storage_bucket_iam_member" "ai_media_viewer" {
  bucket = data.google_storage_bucket.firebase_media.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.ai_sa.email}"
}

resource "google_project_iam_member" "ai_firestore_user" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.ai_sa.email}"
}

resource "google_project_iam_member" "ai_vertex_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.ai_sa.email}"
}

resource "google_project_iam_member" "ai_service_usage" {
  project = var.project_id
  role    = "roles/serviceusage.serviceUsageConsumer"
  member  = "serviceAccount:${google_service_account.ai_sa.email}"
}

# -----------------------------------------------------------------------------
# Preservation processor source package
# -----------------------------------------------------------------------------

data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/../../src/functions/preservation-processor"
  output_path = "${path.module}/function-source.zip"
}

resource "google_storage_bucket_object" "source_zip" {
  name   = "function-build-sources/preservation-${data.archive_file.source.output_sha}.zip"
  bucket = data.google_storage_bucket.uploads_temp.name
  source = data.archive_file.source.output_path
}

resource "google_cloudfunctions2_function" "preservation_processor" {
  depends_on = [
    google_project_iam_member.gcs_pubsub_publisher,
    google_project_iam_member.preservation_run_invoker,
    google_project_iam_member.preservation_event_receiver,
    google_storage_bucket_iam_member.preservation_media_viewer,
    google_storage_bucket_iam_member.preservation_media_creator,
    google_storage_bucket_iam_member.preservation_archive_creator,
    google_project_iam_member.preservation_firestore_user,
  ]

  name        = "preservation-processor"
  location    = var.region
  description = "Preserves canonical Firebase media originals, creates immutable WebP derivatives, and archives the exact source generation."

  build_config {
    runtime     = "python311"
    entry_point = "process_upload"
    source {
      storage_source {
        bucket = data.google_storage_bucket.uploads_temp.name
        object = google_storage_bucket_object.source_zip.name
      }
    }
  }

  service_config {
    max_instance_count    = 10
    available_memory      = "512M"
    timeout_seconds       = 120
    service_account_email = google_service_account.preservation_sa.email
    environment_variables = {
      SOURCE_BUCKET  = data.google_storage_bucket.firebase_media.name
      ARCHIVE_BUCKET = data.google_storage_bucket.archive.name
    }
  }

  event_trigger {
    trigger_region        = var.region
    event_type            = "google.cloud.storage.object.v1.finalized"
    retry_policy          = "RETRY_POLICY_RETRY"
    service_account_email = google_service_account.preservation_sa.email

    event_filters {
      attribute = "bucket"
      value     = data.google_storage_bucket.firebase_media.name
    }
  }
}

# -----------------------------------------------------------------------------
# AI analyzer source package
# -----------------------------------------------------------------------------

data "archive_file" "ai_source" {
  type        = "zip"
  source_dir  = "${path.module}/../../src/functions/ai-analyzer"
  output_path = "${path.module}/ai-analyzer-source.zip"
}

resource "google_storage_bucket_object" "ai_source_zip" {
  name   = "function-build-sources/ai-analyzer-${data.archive_file.ai_source.output_sha}.zip"
  bucket = data.google_storage_bucket.uploads_temp.name
  source = data.archive_file.ai_source.output_path
}

resource "google_cloudfunctions2_function" "ai_analyzer" {
  depends_on = [
    google_project_iam_member.ai_run_invoker,
    google_project_iam_member.ai_event_receiver,
    google_storage_bucket_iam_member.ai_media_viewer,
    google_project_iam_member.ai_firestore_user,
    google_project_iam_member.ai_vertex_user,
    google_project_iam_member.ai_service_usage,
  ]

  name        = "ai-analyzer"
  location    = var.region
  description = "Analyzes preserved Aevum display media using Vision API and Gemini."

  build_config {
    runtime     = "python311"
    entry_point = "analyze_media"
    source {
      storage_source {
        bucket = data.google_storage_bucket.uploads_temp.name
        object = google_storage_bucket_object.ai_source_zip.name
      }
    }
  }

  service_config {
    max_instance_count    = 5
    available_memory      = "1024M"
    timeout_seconds       = 120
    service_account_email = google_service_account.ai_sa.email
    environment_variables = {
      PROJECT_ID      = var.project_id
      GEMINI_MODEL    = var.gemini_model
      GEMINI_LOCATION = var.gemini_location
    }
  }

  event_trigger {
    trigger_region        = var.region
    event_type            = "google.cloud.firestore.document.v1.updated"
    retry_policy          = "RETRY_POLICY_RETRY"
    service_account_email = google_service_account.ai_sa.email

    event_filters {
      attribute = "database"
      value     = "(default)"
    }

    event_filters {
      attribute = "document"
      value     = "media_items/{mediaId}"
      operator  = "match-path-pattern"
    }
  }
}
