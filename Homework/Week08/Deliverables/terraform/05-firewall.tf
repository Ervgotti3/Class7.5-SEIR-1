# Allows inbound HTTP traffic to instances with the http-server network tag.
resource "google_compute_firewall" "allow_http" {
  name    = "week8-allow-http"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
  description   = "Allow inbound HTTP traffic to instances with the http-server network tag."
  depends_on    = [google_compute_instance.week8_vpc]
}