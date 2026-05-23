# This file defines outputs for the Week 10 Terraform lab.
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

output "domain_http_url" {
  description = "HTTP URL using the configured domain name."
  value       = "http://${var.domain_name}"
}

output "domain_https_url" {
  description = "HTTPS URL using the configured domain name."
  value       = "https://${var.domain_name}"
}

output "managed_ssl_certificate_name" {
  description = "Name of the Google-managed SSL certificate."
  value       = google_compute_managed_ssl_certificate.alb.name
}