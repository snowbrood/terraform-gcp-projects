
provider "google" {
    project     = "terraform-gcp-379912"
    credentials = file("credentials.json")
    region      = "us-central1"
    zone        = "us-central1-c"
}

resource "google_compute_instance" "my_instance" {
    name = "terraform-gcp"
    machine_type = "f1-micro"
    zone = "us-central1-a"

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-10"
      }
    }

    network_interface {
        network = google_compute_network.terraform_network.self_link
        subnetwork = google_compute_subnetwork.terraform_subnet.self_link
        access_config {
          
        }
    }
}

resource "google_compute_network" "terraform_network" {
    name = "terraform-network"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "terraform_subnet" {
    name = "terraform-subnetwork"
    ip_cidr_range = "10.20.0.0/16"
    region = "us-central1"
    network = google_compute_network.terraform_network.id
  
}

  

