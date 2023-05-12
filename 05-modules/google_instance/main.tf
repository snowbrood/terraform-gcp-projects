
resource "google_compute_instance" "instance" {
  project      = var.project_id
  name         = var.instance_name
  machine_type = "f1-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral external IP
    }
  }
}
