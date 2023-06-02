variable "buckets" {
  type = map(object({
    location      = string
    storage_class = string
  }))

  default = {
    "bucket1" = {
      location      = "us-central1"
      storage_class = "STANDARD"
    }
    "bucket2" = {
      location      = "europe-west1"
      storage_class = "NEARLINE"
    }
  }
}

resource "google_storage_bucket" "example" {
  for_each      = var.buckets
  name          = each.key
  location      = each.value.location
  storage_class = each.value.storage_class
}
 