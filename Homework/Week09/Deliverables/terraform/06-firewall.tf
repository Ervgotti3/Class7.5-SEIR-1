# This file defines firewall rules for the Week 9 Terraform lab.
# Firewall rules allow us to control network traffic to and from our VM instances.

resource "google_compute_firewall" "allow_http_from_lb" {
  name    = "${var.name_prefix}-allow-http-from-lb"
  network = google_compute_network.vpc.name

  direction     = "INGRESS"
  source_ranges = local.lb_health_check_ranges
  target_tags   = ["allow-lb-health-check"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "${var.name_prefix}-allow-iap-ssh"
  network = google_compute_network.vpc.name

  direction = "INGRESS"

  # IAP TCP forwarding range. This avoids opening SSH to the internet.
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["allow-iap-ssh"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
