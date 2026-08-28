terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
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
  description = "Firebase Storage bucket written by the Aevum clients, for example <project-id>.appspot.com or the configured default bucket name."
  type        = string
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Existing buckets created by infrastructure/data/terraform.
# uploads_temp is now build-source staging only; it is no longer client-facing.
data "google_storage_bucket" "uploads_temp" {
  name = "${var.project_id}-uploads-temp"
}

data "google_storage_bucket" "archive" {
  name = "${var.project_id}-archive"
}

# Firebase Storage is the canonical client upload front door.
data "google_storage_bucket" "firebase_media" {
  name = var.firebase_storage_bucket
}

data "google_project" "current" {
  project_id = var.project_id
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

resource "google_service_account" "function_sa" {
  account_id   = "aevum-media-functions-sa"
  display_name = "Aevum media processing functions"
}

# Cloud Storage direct Eventarc events require the Google-managed GCS service
# account to publish into Pub/Sub.
resource "google_project_iam_member" "gcs_pubsub_publisher" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${data.google_storage_project_service_account.gcs.email_address}"
}

# Eventarc/Cloud Run function delivery identity permissions.
resource "google_project_iam_member" "function_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.function_sa.email}"
}

resource "google_project_iam_member" "function_event_receiver" {
  project = var.project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.function_sa.email}"
}

resource "google_project_iam_member" "function_artifact_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.function_sa.email}"
}

# Preservation/AI functions read canonical originals and derived media.
resource "google_storage_bucket_iam_member" "firebase_media_reader" {
  bucket = data.google_storage_bucket.firebase_media.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.function_sa.email}"
}

# Preservation function creates immutable derivatives in the Firebase bucket.
resource "google_storage_bucket_iam_member" "firebase_media_creator" {
  bucket = data.google_storage_bucket.firebase_media.name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${google_service_account.function_sa.email}"
}

# Preservation function creates immutable archival copies.
resource "google_storage_bucket_iam_member" "archive_bucket_creator" {
  bucket = data.google_storage_bucket.archive.name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${google_service_account.function_sa.email}"
}

resource "google_project_iam_member" "firestore_user" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.function_sa.email}"
}

resource "google_project_iam_member" "ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.function_sa.email}"
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
    google_project_iam_member.function_run_invoker,
    google_project_iam_member.function_event_receiver,
    google_project_iam_member.function_artifact_reader,
    google_storage_bucket_iam_member.firebase_media_reader,
    google_storage_bucket_iam_member.firebase_media_creator,
    google_storage_bucket_iam_member.archive_bucket_creator,
    google_project_iam_member.firestore_user,
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
    service_account_email = google_service_account.function_sa.email
    environment_variables = {
      SOURCE_BUCKET  = data.google_storage_bucket.firebase_media.name
      ARCHIVE_BUCKET = data.google_storage_bucket.archive.name
    }
  }

  event_trigger {
    trigger_region        = var.region
    event_type            = "google.cloud.storage.object.v1.finalized"
    retry_policy          = "RETRY_POLICY_RETRY"
    service_account_email = google_service_account.function_sa.email

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
    google_project_iam_member.function_run_invoker,
    google_project_iam_member.function_event_receiver,
    google_project_iam_member.function_artifact_reader,
    google_storage_bucket_iam_member.firebase_media_reader,
    google_project_iam_member.firestore_user,
    google_project_iam_member.ai_user,
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
    service_account_email = google_service_account.function_sa.email
    environment_variables = {
      PROJECT_ID = var.project_id
    }
  }

  event_trigger {
    trigger_region        = var.region
    event_type            = "google.cloud.firestore.document.v1.updated"
    retry_policy          = "RETRY_POLICY_RETRY"
    service_account_email = google_service_account.function_sa.email

    event_filters {
      attribute = "database"
      value     = "(default)"
    }

    event_filters_path_pattern {
      attribute = "document"
      value     = "media_items/{mediaId}"
    }
  }
}
