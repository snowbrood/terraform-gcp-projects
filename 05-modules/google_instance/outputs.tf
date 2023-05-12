output "instance_name" {
  value = google_compute_instance.instance.name
}

output "instance_self_link" {
  value = google_compute_instance.instance.self_link
}

output "instance_public_ip" {
  value = google_compute_instance.instance.network_interface[0].access_config[0].nat_ip
}
