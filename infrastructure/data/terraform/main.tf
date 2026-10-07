terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  # Partial backend configuration. Supply bucket/prefix during `terraform init`
  # per environment; never keep production state on a developer workstation.
  backend "gcs" {}

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.5"
    }
  }
}

variable "project_id" {
  description = "GCP/Firebase project ID"
  type        = string
}

variable "region" {
  description = "GCP region for storage resources"
  type        = string
  default     = "us-central1"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Build-source staging only. Authenticated users do NOT upload media here.
resource "google_storage_bucket" "uploads_temp" {
  name                        = "${var.project_id}-uploads-temp"
  location                    = var.region
  force_destroy               = false
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  # Function source archives are content-addressed. Retain them long enough for
  # rollback/debugging without leaving an unbounded build-artifact bucket.
  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}

# Immutable-preservation destination for exact source generations.
resource "google_storage_bucket" "archive" {
  name                        = "${var.project_id}-archive"
  location                    = var.region
  storage_class               = "COLDLINE"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  lifecycle_rule {
    condition {
      age = 365
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

# Legacy gallery bucket retained to avoid destructive migration in this release.
# PR-03 moved canonical display/thumbnail derivatives into Firebase Storage.
# Do not add new application dependencies or public CORS behavior here.
resource "google_storage_bucket" "gallery" {
  name                        = "${var.project_id}-gallery"
  location                    = var.region
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
  }
}

# Firestore lifecycle remains managed through the existing Firebase/GCP project.
# If Terraform takes ownership later, import the existing database before adding
# a google_firestore_database resource to avoid replacement/drift.
