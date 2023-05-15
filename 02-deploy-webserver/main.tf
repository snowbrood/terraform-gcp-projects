provider "google" {
  project     = var.gcp_project
  credentials = file("credentials.json")
  region      = var.gcp_region
  zone        = var.gcp_zone
}

# GCP beta provider
provider "google-beta" {
  credentials = file("credentials.json")
  project     = var.gcp_project
  region      = var.gcp_region
}
