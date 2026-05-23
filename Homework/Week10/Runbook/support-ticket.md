# Support Ticket

## Issue Summary

The VM `homework-vm` in `homework-vpc` was not reachable as a public web server, and SSH access was also not working. The VM was expected to serve a basic Apache web page over HTTP and allow administrative access for troubleshooting.

## Environment

- Project: `theowaf-class75-ervink`
- VPC: `homework-vpc`
- VM: `homework-vm`
- Zone: `us-central1-a`
- Internal IP: `10.10.0.2`
- Operating System: Debian 12
- Expected web service: Apache on port `80`

## Observed Behavior

When the issue was first investigated:

- The VM was in `TERMINATED` status.
- The VM did not have an external public IP address.
- SSH access was not working.
- HTTP access was not working.
- The `homework-deny-all` firewall rule was denying all ingress traffic with priority `0`.
- The VM had the `ssh-access` network tag but was missing the `http-server` tag.
- The SSH firewall rule allowed traffic only from `1.2.3.4/32`.
- After SSH was restored, Apache was not installed/running, and `curl localhost` failed on port `80`.

## Expected Behavior
## Troubleshooting Performed
The VM should have been running, reachable by SSH for administration, and serving a basic web page over HTTP. The expected HTTP response was:
Results - You fixed the VM! Yay!

## Troubleshooting Performed
The following troubleshooting steps were performed:

Confirmed the active Google Cloud project.
Listed Compute Engine instances.
Described the VM configuration.
Checked VM status.
Checked external IP configuration.
Reviewed firewall rules in homework-vpc.
Reviewed firewall rule priority.
Checked VM network tags.
Checked SSH access.
Tested IAP/browser SSH access.
Checked Apache service status.
Tested local web access using curl localhost.
Checked whether the VM was listening on port 80.

## Expected Behavior

## Resolution
Starting the VM.
Adjusting the deny-all firewall rule so it no longer overrode the allow rules.
Updating SSH access to work through the correct source range/IAP method.
Adding the missing http-server network tag.
Restoring SSH access.
Installing and starting Apache.
Creating the expected web page at /var/www/html/index.html.
Validating local HTTP access from inside the VM.

## Validation
sudo systemctl status apache2
curl localhost
sudo ss -tulpen | grep :80

## Reference Documentation
The Runbook/README.md

See: Anti-Drunk Engineer Runbook