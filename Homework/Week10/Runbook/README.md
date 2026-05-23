\# Anti-Drunk Engineer Runbook



## End Goal

The goal of this runbook is to troubleshoot a Google Cloud VM that is not working correctly as a public web server and cannot be accessed through SSH. This runbook gives engineers a repeatable process to check the VM, network, firewall rules, routes, SSH access, and web server status. The process should help identify whether the issue is with the VM, network configuration, firewall rules, SSH access, or the web service itself.

## Prerequisites

Before starting, the engineer should have:

- Access to the correct Google Cloud project
- Google Cloud Console access
- Google Cloud CLI installed and authenticated
- Permission to view and modify Compute Engine resources
- Permission to view and modify VPC firewall rules and routes
- Basic understanding of VM instances, VPC networks, firewall rules, network tags, and SSH/IAP
- The broken lab environment already created by the provided command

Confirm the active project before troubleshooting:

```bash
gcloud config get-value project

## Initial Symptoms
The broken environment script was first attempted from local Git Bash and returned exit code `0`, but it did not clearly create or display the expected resources. I then ran the same command from Google Cloud Shell. From Cloud Shell, the script completed successfully and created a VPC named `homework-vpc` with a VM named `homework-vm`.

Created resources identified:
- VPC: `homework-vpc`
- VM: `homework-vm`


## Troubleshooting Procedure

\### 1. Check VM status
 gcloud compute instances list --filter="name=homework-vm"
NAME: homework-vm
ZONE: us-central1-a
MACHINE_TYPE: e2-micro
PREEMPTIBLE: 
INTERNAL_IP: 10.10.0.2
EXTERNAL_IP: 
STATUS: TERMINATED

Finding: The VM `homework-vm` was found in `TERMINATED` status in zone `us-central1-a`. Because the VM was stopped, it could not serve the website and SSH could not connect.

\### 2. Check external IP address
The VM also did not show an external NAT/public IP under the network interface. This means the VM was not directly reachable from the public internet.

\### 3. Check firewall rules
Finding: The `homework-vpc` network had allow rules for HTTP and SSH, but it also had a `homework-deny-all` ingress rule with priority `0`.

Because Google Cloud firewall rules use lower numbers as higher priority, the priority `0` deny-all rule took precedence over the allow rules at priority `1000`. This blocked inbound HTTP and SSH traffic before the allow rules could apply.


\### 4. Check network tags
Run this command: gcloud compute instances describe homework-vm --zone=us-central1-a
The VM only had the following network tag

\### 5. Check routes and VPC/subnet
TBD after route check.


\### 6. Check SSH access
The SSH firewall rule existed, but it only allowed SSH traffic from: 1.2.3.4/32
### Restoring SSH Access

SSH was not working because the VM was stopped, the deny-all firewall rule had priority `0`, and the SSH allow rule only allowed traffic from `1.2.3.4/32`.

Since the VM did not have an external IP address, I used IAP SSH as the preferred recovery method.

Commands used:

```bash
gcloud compute instances start homework-vm --zone=us-central1-a

gcloud compute firewall-rules update homework-deny-all --priority=65534

gcloud compute firewall-rules update homework-allow-ssh \
  --source-ranges=35.235.240.0/20

gcloud compute ssh homework-vm \
  --zone=us-central1-a \
  --tunnel-through-iap

\### 7. Check IAP SSH access
IAP SSH was documented as an alternate access method because the VM did not have an external public IP address.

Command to test IAP SSH:

```bash
gcloud compute ssh homework-vm \
  --zone=us-central1-a \
  --tunnel-through-iap


\### 8. Check serial console logs
Serial console logs should be checked when the VM is not reachable through SSH or the web service is not responding.

Console path: Compute Engine > VM instances > homework-vm > Logs > Serial port 1
Results = The VM metadata showed that the startup script was intended to install Apache, start Apache, and write a basic web page to /var/www/html/index.html. If Apache did not start correctly, the serial console logs would be one of the first places to check for startup script errors.

\### 9. Check web server status
Finding:

SSH access was restored, but Apache was not installed or running.

Command used:

```bash
sudo systemctl status apache2


\### 10. Check listening ports
If no service is listening on port 80, public HTTP access will fail even if the firewall rule allows traffi


\### 11. Check startup script behavior



\## Root Cause
The broken VM had multiple issues:

The VM homework-vm was in TERMINATED status.
The VM did not have an external public IP address.
The homework-deny-all firewall rule denied all ingress traffic from 0.0.0.0/0 with priority 0.
The HTTP firewall rule required the http-server network tag, but the VM only had the ssh-access tag.
The SSH firewall rule only allowed source range 1.2.3.4/32, which did not match my actual SSH source.


\## Resolution
The resolution steps were:

1. Started the VM.
2. Lowered the priority of the `homework-deny-all` firewall rule so it would not override the allow rules.
3. Updated the SSH firewall rule to allow IAP SSH traffic from `35.235.240.0/20`.
4. Confirmed SSH access worked through the browser/IAP method.
5. Added the missing `http-server` network tag to the VM.
6. Installed and started Apache.
7. Created the expected index page at `/var/www/html/index.html`.
8. Confirmed Apache was running and listening on port `80`.


\## Validation
Validation should confirm:

VM is running.
VM has the correct network tags.
Firewall rules allow HTTP and SSH as expected.
Deny-all rule no longer overrides required allow rules.
Web server is running.
Port 80 is listening.
Public HTTP test works.

Run this on new vm named - homework-vm 
curl localhost
Results - You fixed the VM! Yay!


\## Partner Testing Notes

