provider "google" {
  credentials = file("credentials.json")
  project = var.project_id
  region  = "us-central1"
}

module "gcp_instance" {
  source = "C:/Users/A200126408/code/projects/terraform/05-modules/google_instance"

  project_id    = var.project_id
  instance_name = "my-instance"
}

output "instance_name" {
  value = module.gcp_instance.instance_name
}

output "instance_self_link" {
  value = module.gcp_instance.instance_self_link
}

output "instance_public_ip" {
    value = module.gcp_instance.instance_public_ip
}

