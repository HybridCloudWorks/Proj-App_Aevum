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
  description = "GCP Region for resources"
  type        = string
  default     = "us-central1"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Ingestion Bucket (Temporary Holding)
# Users upload here directly.
resource "google_storage_bucket" "uploads_temp" {
  name          = "${var.project_id}-uploads-temp"
  location      = var.region
  force_destroy = false
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 1 # Delete temp files after 24 hours if processing failed or succeeded and moved
    }
    action {
      type = "Delete"
    }
  }

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

# 2. Archive Bucket (Cold Storage - The "Digital Negative")
# Stores original high-res uploads (TIFF, RAW, PNG).
resource "google_storage_bucket" "archive" {
  name          = "${var.project_id}-archive"
  location      = var.region
  storage_class = "COLDLINE"
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 365 # Move to Archive (Deep Cold) after 1 year if untouched
    }
    action {
      type          = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
  }

  versioning {
    enabled = true
  }
}

# 3. Gallery Bucket (Hot/Warm Storage - Display)
# Stores optimized WebP versions for the app.
resource "google_storage_bucket" "gallery" {
  name          = "${var.project_id}-gallery"
  location      = var.region
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE" # Move display assets to cheaper tier if not viewed in 3 months
    }
  }

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

# Note: Firestore is often created manually via Firebase Console, but this resource exists if needed.
# resource "google_firestore_database" "database" {
#   project     = var.project_id
#   name        = "(default)"
#   location_id = var.region
#   type        = "FIRESTORE_NATIVE"
# }
