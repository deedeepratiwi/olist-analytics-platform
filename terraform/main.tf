terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

# GCS bucket
resource "google_storage_bucket" "olist-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  storage_class = var.gcs_storage_class
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

# Raw dataset
resource "google_bigquery_dataset" "olist_raw" {
  dataset_id = var.bq_dataset_raw
  location   = var.location
}

# Analytics dataset
resource "google_bigquery_dataset" "olist_analytics" {
  dataset_id = var.bq_dataset_analytics
  location   = var.location
}