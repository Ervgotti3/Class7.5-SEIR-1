## Terraform

### Purpose

The Terraform portion of this assignment provisions a single Google Compute Engine VM using infrastructure as code. The VM is built with CentOS Stream 10, an N-series machine type, a 100 GB root persistent disk, an external IP address, and a startup script that installs and starts the required web service.

The Terraform configuration is stored in the `terraform/` subdirectory and is designed so another engineer can clone the repo and run:

```bash
terraform init
terraform validate
terrafrom plan
terraform apply -auto-approve

terraform/
├── .gitignore
├── 01-provider.tf
├── 02-vpc.tf
├── 03-data.tf
├── 02-variables.tf
├── 04-variables.tf
├── 05-firewall.tf
└── 06-outputs.tf

For the google_compute_instance resource, the required arguments are the minimum settings Terraform needs to create a VM in Google Cloud.

name
This is the name assigned to the VM resource. It is the human-readable name I chose for the virtual machine.
machine_type
This defines the size and family of the VM. For this assignment, I selected an N-series machine type to meet the requirement.
zone
This tells Google Cloud which zone to create the VM in. I originally used us-east1-b, but changed zones after receiving a temporary Google Cloud capacity error for the selected machine type.
boot_disk
This block defines the VM boot disk. Inside this block, I used initialize_params to define the operating system image and the root disk size.
network_interface
This block defines how the VM connects to the VPC network. I used the default VPC and included an access_config block so the VM receives an external IP address.

Startup Script

The assignment provided a startup script for RHEL-based systems. Since CentOS is related to RHEL, this script is more appropriate than using commands designed for Debian or Ubuntu systems.

The script was downloaded with:
curl -o startup.sh https://raw.githubusercontent.com/aaron-dm-mcdonald/class7.5-notes/refs/heads/main/week-8/hw/startup-for-rhel.sh

### Terraform Commands Used
terraform fmt was used to format the configuration using Terraform’s standard style.
terraform init downloaded the required provider plugin.
terraform validate checked the syntax and structure of the configuration.
terraform plan previewed the resources Terraform would create.
terraform apply created the VM in Google Cloud.
terraform output displayed the VM internal IP, external IP, name, ID, and self link.


### Troubleshooting Note

During the first Terraform apply, the VM failed to create because the `us-central1` zone did not have enough capacity for the selected `n1-standard-1` machine type. This was not a Terraform syntax issue or quota issue. I resolved it by changing the VM zone to another zone in the same region and changing the machine type to `n2-standard-2` then rerunning `terraform apply`.