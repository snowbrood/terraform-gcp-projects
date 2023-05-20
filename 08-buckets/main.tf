terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
  required_version = ">= 0.13"
}

provider "google" {
  credentials = file("<PATH TO YOUR SERVICE ACCOUNT KEY>")
  project     = "<PROJECT ID>"
  region      = "us-central1"
}

resource "google_storage_bucket" "bucket" {
  name     = "my-gcs-bucket"
  location = "US"

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = 365
    }
  }
}
