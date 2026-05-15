# Create a health check, instance templates, and (MIG) managed instance groups 
# for the Colombia and thailand backends.

resource "google_compute_health_check" "http" {
  name = "${var.name_prefix}-http-health-check"

  timeout_sec         = 5
  check_interval_sec  = 10
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    port         = 80
    request_path = "/"
  }
}
# Create a VPC with no default subnetworks. We'll create custom subnets in the next step.
resource "google_compute_instance_template" "colombia" {
  name_prefix  = "${var.name_prefix}-colombia-"
  machine_type = var.machine_type
  tags         = local.web_target_tags

  lifecycle {
    create_before_destroy = true
  }

  disk {
    boot         = true
    auto_delete  = true
    source_image = "debian-cloud/debian-12"
    disk_size_gb = 10
    disk_type    = "pd-balanced"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.web.id
    # No access_config block means no public VM IP.
    # Cloud NAT provides outbound internet for package installation.
  }

# The metadata startup script installs nginx and creates simple static pages for testing the load balancer.
  metadata_startup_script = <<-EOT
    #!/bin/bash
    set -euxo pipefail

    apt-get update
    apt-get install -y nginx

    mkdir -p /var/www/html/colombia

    cat > /var/www/html/index.html <<'HTML'
    <!doctype html>
    <html>
      <head>
        <title>Colombia Backend</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 40px; background: #f7f7f7; }
          .card { background: white; padding: 30px; border-radius: 12px; max-width: 700px; }
          h1 { margin-top: 0; }
        </style>
      </head>
      <body>
        <div class="card">
          <h1>Colombia Backend</h1>
          <p>This response came from the Colombia managed instance group.</p>
          <p>Test path: <strong>/colombia</strong></p>
        </div>
      </body>
    </html>
    HTML

    cat > /var/www/html/colombia/index.html <<'HTML'
    <!doctype html>
    <html>
      <head>
        <title>Colombia Page</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 40px; background: #fff8e1; }
          .card { background: white; padding: 30px; border-radius: 12px; max-width: 700px; border: 3px solid #f4c430; }
          .avatar { font-size: 80px; }
          h1 { margin-top: 0; }
        </style>
      </head>
      <body>
        <div class="card">
          <div class="avatar">🇨🇴 👩🏽‍💻</div>
          <h1>Colombia Page</h1>
          <p>Simple Colombia-themed static page served by the Colombia backend service.</p>
        </div>
      </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl restart nginx
  EOT
}

# The thailand instance template and managed instance group are similar to the Colombia ones, 
# just with different metadata startup scripts for unique page content.

resource "google_compute_instance_template" "thailand" {
  name_prefix  = "${var.name_prefix}-thailand-"
  machine_type = var.machine_type
  tags         = local.web_target_tags

  lifecycle {
    create_before_destroy = true
  }

  disk {
    boot         = true
    auto_delete  = true
    source_image = "debian-cloud/debian-12"
    disk_size_gb = 10
    disk_type    = "pd-balanced"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.web.id
    # No access_config block means no public VM IP.
    # Cloud NAT provides outbound internet for package installation.
  }

# The metadata startup script installs nginx and creates simple static pages for testing the load balancer.
  metadata_startup_script = <<-EOT
    #!/bin/bash
    set -euxo pipefail

    apt-get update
    apt-get install -y nginx

    mkdir -p /var/www/html/thailand

    cat > /var/www/html/index.html <<'HTML'
    <!doctype html>
    <html>
      <head>
        <title>thailand Backend</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 40px; background: #f7f7f7; }
          .card { background: white; padding: 30px; border-radius: 12px; max-width: 700px; }
          h1 { margin-top: 0; }
        </style>
      </head>
      <body>
        <div class="card">
          <h1>thailand Backend</h1>
          <p>This response came from the thailand managed instance group.</p>
          <p>Test path: <strong>/thailand</strong></p>
        </div>
      </body>
    </html>
    HTML

    cat > /var/www/html/thailand/index.html <<'HTML'
    <!doctype html>
    <html>
      <head>
        <title>thailand Page</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 40px; background: #eef7ff; }
          .card { background: white; padding: 30px; border-radius: 12px; max-width: 700px; border: 3px solid #4169e1; }
          .avatar { font-size: 80px; }
          h1 { margin-top: 0; }
        </style>
      </head>
      <body>
        <div class="card">
          <div class="avatar">🇹🇭 👩🏻‍💻</div>
          <h1>thailand Page</h1>
          <p>Simple thailand-themed static page served by the thailand backend service.</p>
        </div>
      </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl restart nginx
  EOT
}
# Create managed instance groups for the Colombia backend.
resource "google_compute_region_instance_group_manager" "colombia" {
  name               = "${var.name_prefix}-colombia-mig"
  base_instance_name = "${var.name_prefix}-colombia"
  region             = var.region
  target_size        = var.mig_target_size

  version {
    instance_template = google_compute_instance_template.colombia.id
  }

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.http.id
    initial_delay_sec = 120
  }
}

# Create managed instance groups for the thailand backend.
resource "google_compute_region_instance_group_manager" "thailand" {
  name               = "${var.name_prefix}-thailand-mig"
  base_instance_name = "${var.name_prefix}-thailand"
  region             = var.region
  target_size        = var.mig_target_size

  version {
    instance_template = google_compute_instance_template.thailand.id
  }

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.http.id
    initial_delay_sec = 120
  }
}
