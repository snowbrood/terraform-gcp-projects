# Variables Configuration
variable "project_id" {
  description = "The ID of the project"
  type        = string
}

variable "bucket_name" {
  description = "The name of the storage bucket"
  type        = string
}

variable "dataset_id" {
  description = "The ID of the BigQuery dataset"
  type        = string
}

variable "table_id" {
  description = "The ID of the BigQuery table"
  type        = string
}

# Provider Configuration
provider "google" {
  project = var.project_id
  region  = "us-central1"
}

# Create Cloud Storage Bucket (Data Source)
resource "google_storage_bucket" "data_source" {
  name = var.bucket_name
}

# Cloud Function for Data Processing
resource "google_cloudfunctions_function" "data_processing" {
  name         = "data-processing-function"
  description  = "Function for processing data"
  runtime      = "nodejs14"
  entry_point  = "processData"
  trigger_http = true

  source_archive_bucket = google_storage_bucket.data_source.name
  source_archive_object = "function.zip"
}

# BigQuery Dataset and Table (Data Storage)
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.dataset_id
}

resource "google_bigquery_table" "table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_id

  schema = <<EOF
[
  { "name": "field1", "type": "STRING" },
  { "name": "field2", "type": "INTEGER" }
]
EOF
}

# Cloud Scheduler for Orchestration
resource "google_cloud_scheduler_job" "orchestration_job" {
  name        = "data-pipeline-job"
  description = "Orchestration job for data pipeline"
  schedule    = "every 1 day"

  target {
    http_target {
      uri = google_cloudfunctions_function.data_processing.https_trigger_url
      http_method = "POST"
    }
  }
}
