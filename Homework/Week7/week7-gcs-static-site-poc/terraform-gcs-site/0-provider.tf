terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

# Configure the Google Provider
provider "google" {
  project = var.project_id
  region  = var.region
}
