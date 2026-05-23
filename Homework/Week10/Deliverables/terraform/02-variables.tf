# This file defines variables for the Week 10 Terraform lab. 
# Variables allow us to easily customize our infrastructure by changing values in one place, 
# rather than hardcoding them throughout our configuration files.

variable "project_id" {
  description = "The Google Cloud project ID where the vpc will be created."
  type        = string

}

variable "name_prefix" {
  description = "Prefix used for all Week 10 lab resources."
  type        = string
  #default     = "week10-alb"
}

variable "region" {
  description = "Region for the subnet, Cloud NAT, and regional managed instance groups."
  type        = string
  #default     = "us-east1"
}

variable "zone" {
  description = "Default provider zone. Change this if a zone has capacity issues."
  type        = string
  #default     = "us-east1-c"
}

variable "subnet_cidr" {
  description = "CIDR range for the custom VPC subnet."
  type        = string
  default     = "10.90.0.0/24"
}

variable "machine_type" {
  description = "Small machine type for lab cost control."
  type        = string
  #default     = "e2-micro"
}

variable "mig_target_size" {
  description = "Number of VM instances in each managed instance group."
  type        = number
  default     = 1
}

variable "enable_cdn" {
  description = "Enable Cloud CDN on the backend services. Keep false while testing page changes."
  type        = bool
  default     = false
}

locals {
  # Google load balancer and health check source ranges for backend VM firewall rules.
  lb_health_check_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16",
  ]

  web_target_tags = [
    "allow-lb-health-check",
    "allow-iap-ssh",
  ]
}

variable "domain_name" {
  description = "Fully qualified domain name used for the HTTPS load balancer."
  type        = string
  #default     = "www.jshaw7.com"
}

variable "managed_zone_name" {
  description = "Existing Cloud DNS managed zone name."
  type        = string
  #default     = "jshaw7-com"
}
