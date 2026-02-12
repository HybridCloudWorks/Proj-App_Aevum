terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Data Sources for Existing Buckets (Created in data/terraform)
data "google_storage_bucket" "uploads_temp" {
  name = "${var.project_id}-uploads-temp"
}

data "google_storage_bucket" "archive" {
  name = "${var.project_id}-archive"
}

data "google_storage_bucket" "gallery" {
  name = "${var.project_id}-gallery"
}

# Enable Required APIs
resource "google_project_service" "apis" {
  for_each = toset([
    "run.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudbuild.googleapis.com",
    "eventarc.googleapis.com",
    "artifactregistry.googleapis.com",
    "vision.googleapis.com"
  ])
  service = each.key
  disable_on_destroy = false
}

# Service Account for the Function
resource "google_service_account" "function_sa" {
  account_id   = "preservation-processor-sa"
  display_name = "Preservation Processor Function SA"
}

# IAM: Grant Function SA access to Buckets
# 1. Read/Delete from Temp
resource "google_storage_bucket_iam_member" "temp_bucket_admin" {
  bucket = data.google_storage_bucket.uploads_temp.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.function_sa.email}"
}

# 2. Write to Archive
resource "google_storage_bucket_iam_member" "archive_bucket_writer" {
  bucket = data.google_storage_bucket.archive.name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${google_service_account.function_sa.email}"
}

# 3. Write to Gallery
resource "google_storage_bucket_iam_member" "gallery_bucket_writer" {
  bucket = data.google_storage_bucket.gallery.name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${google_service_account.function_sa.email}"
}

# 4. Write to Firestore
resource "google_project_iam_member" "firestore_user" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.function_sa.email}"
}

# Cloud Function (Gen 2)
resource "google_cloudfunctions2_function" "preservation_processor" {
  name        = "preservation-processor"
  location    = var.region
  description = "Processes raw uploads: resizes to WebP and moves original to Archive."

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
    max_instance_count = 10
    available_memory   = "512M" # Sufficient for image processing
    timeout_seconds    = 60
    service_account_email = google_service_account.function_sa.email
    environment_variables = {
      TEMP_BUCKET    = data.google_storage_bucket.uploads_temp.name
      ARCHIVE_BUCKET = data.google_storage_bucket.archive.name
      GALLERY_BUCKET = data.google_storage_bucket.gallery.name
    }
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.storage.object.v1.finalized"
    retry_policy   = "RETRY_POLICY_RETRY"
    service_account_email = google_service_account.function_sa.email
    event_filters {
      attribute = "bucket"
      value     = data.google_storage_bucket.uploads_temp.name
    }
  }
}

# Zip Source Code (Locally) and Upload to Temp Bucket for Build
data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/../../src/functions/preservation-processor"
  output_path = "${path.module}/function-source.zip"
}

resource "google_storage_bucket_object" "source_zip" {
  name   = "preservation-source-${data.archive_file.source.output_sha}.zip"
  bucket = data.google_storage_bucket.uploads_temp.name
  source = data.archive_file.source.output_path
}

# --- AI Analyzer Function ---

# Archive for AI Analyzer source
data "archive_file" "ai_source" {
  type        = "zip"
  source_dir  = "${path.module}/../../src/functions/ai-analyzer"
  output_path = "${path.module}/ai-analyzer-source.zip"
}

resource "google_storage_bucket_object" "ai_source_zip" {
  name   = "ai-analyzer-source-${data.archive_file.ai_source.output_sha}.zip"
  bucket = data.google_storage_bucket.uploads_temp.name
  source = data.archive_file.ai_source.output_path
}

# Cloud Function (Gen 2) - AI Analyzer
resource "google_cloudfunctions2_function" "ai_analyzer" {
  name        = "ai-analyzer"
  location    = var.region
  description = "Analyzes photos using Vision API: labels, faces, OCR."

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
    max_instance_count = 5
    available_memory   = "1024M" # Vision API and heavy libraries need more RAM
    timeout_seconds    = 120
    service_account_email = google_service_account.function_sa.email
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.firestore.document.v1.updated"
    retry_policy   = "RETRY_POLICY_RETRY"
    service_account_email = google_service_account.function_sa.email
    
    event_filters {
      attribute = "database"
      value     = "(default)"
    }
    event_filters {
      attribute = "document"
      # Regex or pattern for all documents in media_items
      value     = "media_items/{id}"
    }
  }
}
