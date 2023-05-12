variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "instance_name" {
  description = "The name of the GCE instance."
  type        = string
}

variable "zone" {
  description = "The GCP zone where the instance will be created."
  type        = string
  default     = "us-central1-a"
}
