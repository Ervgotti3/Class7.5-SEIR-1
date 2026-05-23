# This file defines resources for the HTTP load balancer in the Week 10 Terraform lab.
# The load balancer distributes incoming HTTP traffic across the Colombia and thailand backend services.

resource "google_compute_global_address" "alb_ip" {
  name = "${var.name_prefix}-global-ip"
}

resource "google_compute_backend_service" "colombia" {
  name                  = "${var.name_prefix}-colombia-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30
  enable_cdn            = var.enable_cdn

  health_checks = [google_compute_health_check.http.id]

  backend {
    group           = google_compute_region_instance_group_manager.colombia.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 1.0
  }
}

resource "google_compute_backend_service" "thailand" {
  name                  = "${var.name_prefix}-thailand-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30
  enable_cdn            = var.enable_cdn

  health_checks = [google_compute_health_check.http.id]

  backend {
    group           = google_compute_region_instance_group_manager.thailand.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 1.0
  }
}
# Create a URL map to route traffic to the correct backend service based on URL path.
resource "google_compute_url_map" "alb" {
  name = "${var.name_prefix}-url-map"

  # Default route if the user browses to http://IP/ without a path.
  default_service = google_compute_backend_service.colombia.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "week9-paths"
  }

  path_matcher {
    name            = "week9-paths"
    default_service = google_compute_backend_service.colombia.id

    path_rule {
      paths   = ["/colombia", "/colombia/*"]
      service = google_compute_backend_service.colombia.id
    }

    path_rule {
      paths   = ["/thailand", "/thailand/*"]
      service = google_compute_backend_service.thailand.id
    }
  }
}

resource "google_compute_target_http_proxy" "alb" {
  name    = "${var.name_prefix}-http-proxy"
  url_map = google_compute_url_map.alb.id
}

resource "google_compute_global_forwarding_rule" "http" {
  name                  = "${var.name_prefix}-http-forwarding-rule"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  ip_protocol           = "TCP"
  port_range            = "80"
  ip_address            = google_compute_global_address.alb_ip.address
  target                = google_compute_target_http_proxy.alb.id
}

#Add the HTTPS/DNS resources in the next step of the lab,
#so they don't interfere with testing page changes on the HTTP load balancer.

data "google_dns_managed_zone" "primary" {
  name = var.managed_zone_name
}

resource "google_compute_managed_ssl_certificate" "alb" {
  name = "${var.name_prefix}-managed-cert"
  managed {
    domains = [var.domain_name]
  }
}

resource "google_compute_target_https_proxy" "alb" {
  name             = "${var.name_prefix}-https-proxy"
  url_map          = google_compute_url_map.alb.id
  ssl_certificates = [google_compute_managed_ssl_certificate.alb.id]
}

resource "google_compute_global_forwarding_rule" "https" {
  name                  = "${var.name_prefix}-https-forwarding-rule"
  ip_address            = google_compute_global_address.alb_ip.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  target                = google_compute_target_https_proxy.alb.id
}

resource "google_dns_record_set" "alb_a_record" {
  name         = "${var.domain_name}."
  managed_zone = data.google_dns_managed_zone.primary.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_global_address.alb_ip.address]
}