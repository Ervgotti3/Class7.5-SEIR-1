output "vpc_internal_ip" {
  description = "The internal/private IP address assigned to the vpc."
  value       = google_compute_instance.week8_vpc.network_interface[0].network_ip
}

output "vpc_external_ip" {
  description = "The external/public IP address assigned to the vpc."
  value       = google_compute_instance.week8_vpc.network_interface[0].access_config[0].nat_ip
}

output "vpc_name" {
  description = "The name of the vpc."
  value       = google_compute_instance.week8_vpc.name
}

output "vpc_id" {
  description = "The Terraform/GCP ID of the vpc."
  value       = google_compute_instance.week8_vpc.id
}

output "vpc_self_link" {
  description = "The self_link URL for the vpc resource."
  value       = google_compute_instance.week8_vpc.self_link
}