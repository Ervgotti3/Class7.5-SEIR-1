# This file defines resources for the HTTP load balancer in the Week 9 Terraform lab.
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
