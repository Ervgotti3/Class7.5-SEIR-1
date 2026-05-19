variable "project_id" {
  description = "The Google Cloud project ID where the vpc will be created."
  type        = string
  default     = "theowaf-class75-ervink"
}

variable "region" {
  description = "The Google Cloud region used by the provider."
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "The Google Cloud zone where the vpc will be created."
  type        = string
  default     = "us-east1-c"
}

variable "vpc_name" {
  description = "The name of the Week 8 CentOS Stream 10 vpc."
  type        = string
  default     = "week8-centos-stream-10-vpc"
}

variable "machine_type" {
  description = "The N-series machine type for the vpc."
  type        = string
  default     = "n2-standard-2"
}