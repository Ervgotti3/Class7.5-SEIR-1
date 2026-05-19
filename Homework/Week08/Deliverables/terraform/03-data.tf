# Use the default VPC for this assignment.
data "google_compute_network" "default" {
  name = "default"
}

# Use the latest non-deprecated CentOS Stream 10 image from the public centos-cloud project.
data "google_compute_image" "centos_stream_10" {
  family  = "centos-stream-10"
  project = "centos-cloud"
}