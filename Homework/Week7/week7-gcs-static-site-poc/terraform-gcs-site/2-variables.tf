variable "project_id" {
  description = "Google Project ID"
  type        = string
  default     = "theowaf-class75-ervink"
}

variable "bucket_name" {
  description = "Name of the GCS bucket to create"
  type        = string
  default     = "week7-gcs-static-site-ervink"
}

variable "region" {
  description = "Google Region for resources"
  type        = string
  default     = "us-central1"
}

variable "location" {
  description = "Google Location for resources"
  type        = string
  default     = "US"
}