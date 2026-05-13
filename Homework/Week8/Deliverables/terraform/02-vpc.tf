resource "google_compute_instance" "week8_vpc" {
  name         = var.vpc_name
  machine_type = var.machine_type
  zone         = var.zone

  # This tag matches the firewall rule that allows inbound HTTP traffic.
  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.centos_stream_10.self_link
      size  = 100
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link

    # Empty access_config block creates an ephemeral external IP.
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    set -e

    curl -o /tmp/startup.sh https://raw.githubusercontent.com/aaron-dm-mcdonald/class7.5-notes/refs/heads/main/week-8/hw/startup-for-rhel.sh
    chmod +x /tmp/startup.sh
    bash /tmp/startup.sh
  EOT
}