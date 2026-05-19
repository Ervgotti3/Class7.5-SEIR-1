# This file defines outputs for the Week 9 Terraform lab.
# Outputs allow us to easily access important information about our infrastructure after it's created.

output "load_balancer_ip" {
  description = "Global external Application Load Balancer IP address."
  value       = google_compute_global_address.alb_ip.address
}

output "colombia_url" {
  description = "Test URL for the Colombia backend service."
  value       = "http://${google_compute_global_address.alb_ip.address}/colombia"
}

output "thailand_url" {
  description = "Test URL for the thailand backend service."
  value       = "http://${google_compute_global_address.alb_ip.address}/thailand"
}

output "cdn_enabled" {
  description = "Shows whether Cloud CDN is enabled on backend services."
  value       = var.enable_cdn
}

output "ssh_note" {
  description = "Optional troubleshooting note."
  value       = "Instances do not have public IPs. Use IAP SSH from the Google Console if you need to troubleshoot."
}
