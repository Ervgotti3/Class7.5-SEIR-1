# Week 8 Homework - Managed Instance Groups, Load Balancing, and Terraform VM Provisioning

## Overview

This Week 8 assignment covers Google Cloud managed instance groups, instance templates, autohealing, autoscaling, load balancing concepts, high availability, fault tolerance, and Terraform VM provisioning.

The assignment has two main parts:

1. A **ClickOps runbook** for creating a fully configured managed instance group in the Google Cloud Console.
2. A **Terraform configuration** that provisions a single Google Compute Engine VM using CentOS Stream 10.

---

## Repository Structure

```text
Week8/
├── README.md
├── Deliverables/
│   └── terraform/
│       ├── .gitignore
│       ├── 00-versions.tf
│       ├── 01-provider.tf
│       ├── 02-variables.tf
│       ├── 03-data.tf
│       ├── 04-firewall.tf
│       ├── 05-vm.tf
│       ├── 06-outputs.tf
│       └── startup.sh
└── screenshots/
    ├── clickops-mig/
    └── terraform-vm/
```

---

## Documentation and Resources Used

- Google Cloud Managed Instance Groups documentation  
  Used to understand managed instance groups, unmanaged instance groups, instance templates, autoscaling, autohealing, and multi-zone managed instance groups.

- Google Cloud Instance Groups overview  
  Used to compare managed and unmanaged instance groups and understand when each type should be used.

- Google Cloud Load Balancing documentation  
  Used to understand how Google Cloud load balancers distribute traffic and use health checks to determine whether backend resources are healthy.

- Google Cloud Application Load Balancer documentation  
  Used to understand external application load balancing and the relationship between load balancers, backends, health checks, and application traffic.

- Google Cloud HTTPS Load Balancing documentation  
  Used to understand how HTTPS load balancing fits into production architecture and why load balancing is important for resilient applications.

- Google Cloud Three-Tier Web Services documentation  
  Used to understand how web, application, and database tiers can be separated in a cloud architecture.

- Google Cloud Infrastructure Reliability Design Guide  
  Used to understand high availability, fault tolerance, redundancy, and reliability design principles.

- Terraform Google Provider documentation  
  Used to identify the required and optional arguments for creating a `google_compute_instance` resource.

- Instructor-provided startup script  
  Used as the VM startup script because the assignment requires a RHEL-compatible script for CentOS Stream 10.

---

## Q & A

### What is the difference between high availability and fault tolerance? Which is best to strive for?

High availability means designing systems to reduce downtime and recover quickly when a failure happens. Fault tolerance means the system can continue operating even when one or more components fail, usually with little or no interruption. In most environments, high availability is the more practical goal because full fault tolerance can be more expensive and complex. For critical systems, the best design may include both high availability and fault-tolerant components where needed.

### Explain the difference between autoscaling and elasticity. What is vertical and horizontal autoscaling? Is one better? Are they feasible on prem?

Autoscaling is the process of automatically adding or removing resources based on demand, such as CPU utilization or request load. Elasticity is the broader cloud capability of growing and shrinking resources as business demand changes. Vertical scaling means increasing the size of an existing server, such as adding more CPU or memory, while horizontal scaling means adding more servers or instances. Horizontal scaling is usually better for cloud web applications because it avoids relying on one large server, but vertical scaling is still useful for workloads that cannot easily be distributed. Both are possible on-prem, but they are usually harder and slower because physical hardware capacity has to be purchased, installed, and maintained.

### Explain what the difference between managed and unmanaged instance groups is.

A managed instance group uses an instance template so Google Cloud can create and manage identical VM instances as a group. Managed instance groups support features such as autoscaling, autohealing, rolling updates, and multi-zone deployment. An unmanaged instance group is a collection of existing VM instances that are grouped together manually. Unmanaged instance groups can be useful for load balancing existing VMs, but they do not provide the same automation and lifecycle management features as managed instance groups.

### Explain the different use cases for health checks used by applications in instance groups and health checks used by load balancers. Can they be the same? Are they different API calls? Should they be the same?

A managed instance group autohealing health check is used to decide whether a VM instance should be repaired or recreated. A load balancer health check is used to decide whether traffic should be sent to a backend instance or removed from rotation. They can check the same application endpoint, such as HTTP port 80, but they are used for different operational decisions. They are configured as health check resources, but they are attached to different services or policies depending on the use case. They can be the same endpoint, but they should only be identical if the same test accurately proves both instance health and application readiness.

### Explain in a few sentences what the three-tier architecture is and how it relates to what you are learning.

A three-tier architecture separates an application into a web tier, application tier, and database tier. The web tier handles user-facing traffic, the application tier handles business logic, and the database tier stores application data. This relates to instance groups and load balancing because cloud applications often use load balancers in front of web or application tiers, while managed instance groups provide scalable and highly available compute resources.

---

## Runbook

### End Goal

Create a fully configured managed instance group using the Google Cloud Console. The group should use an instance template, support autoscaling, support autohealing, and manage VM instances across multiple zones.

### Prerequisites

- Access to a Google Cloud project.
- Compute Engine API enabled.
- IAM permissions to create instance templates, managed instance groups, firewall rules, and health checks.
- A VPC and subnet selected before starting.
- A startup script or image that installs and runs the application.
- Firewall access for the application port, such as port 80 for HTTP.
- Firewall access for Google Cloud health check probes.

### Create the Instance Template

1. Go to **Compute Engine > Instance templates**.
2. Select **Create instance template**.
3. Enter a clear template name.
4. Select the machine type required for the workload.
5. Select the boot disk image.
6. Select the network and subnet.
7. Add any required network tags, such as `http-server`.
8. Add a startup script if the application should be installed during boot.
9. Review the settings and create the template.

### Create the Managed Instance Group

1. Go to **Compute Engine > Instance groups**.
2. Select **Create instance group**.
3. Choose **New managed instance group**.
4. Select the instance template created earlier.
5. Choose **Regional** if the group should run across multiple zones.
6. Select the region and zones.
7. Set the initial number of instances.
8. Review and create the managed instance group.

### Enable Autoscaling

1. Open the managed instance group.
2. Select **Edit**.
3. Enable autoscaling.
4. Set the minimum and maximum number of instances.
5. Select a scaling signal, such as CPU utilization.
6. Set the target utilization value.
7. Save the configuration.

### Enable Autohealing

1. Create or select a health check.
2. Attach the health check to the managed instance group autohealing policy.
3. Set the initial delay high enough for the VM startup script and application service to complete startup.
4. Save the configuration.

### Verify Multi-Zone Management

1. Open the managed instance group details page.
2. Confirm the group location type is **Regional**.
3. Review the zones listed for the group.
4. Open the managed instances section.
5. Confirm instances are running in more than one zone.
6. If instances are not spread across zones, review the selected zones and distribution settings.

### Critical Configuration Notes

- Use a managed instance group, not an unmanaged instance group.
- Use an instance template so the group can recreate instances consistently.
- Configure autoscaling with reasonable minimum and maximum values.
- Configure autohealing with a health check that accurately reflects application readiness.
- Make sure firewall rules allow the application traffic and health check probes.
- Use a regional managed instance group when the goal is multi-zone availability.

---

## Terraform

### Purpose

The Terraform portion provisions a single Google Compute Engine VM. The VM uses CentOS Stream 10, an N-series machine type, a 100 GB boot disk, an external IP address, and the instructor-provided startup script.

The Terraform configuration is located in:

```text
Week8/Deliverables/terraform/
```

### Required Arguments for a VM in Terraform

For the `google_compute_instance` resource, Terraform needs several required arguments to create a VM.

- `name`  
  The name assigned to the VM. This is the readable name that appears in Google Cloud.

- `machine_type`  
  The machine family and size for the VM. For this assignment, the VM must use an N-series machine type.

- `zone`  
  The Google Cloud zone where the VM is created.

- `boot_disk`  
  Defines the VM boot disk. This assignment requires the root persistent disk to be 100 GB.

- `network_interface`  
  Defines the network connection for the VM. The VM must include an external IP, which is configured using an `access_config` block.

### CentOS Stream 10 Image Format

To figure out the correct image format for CentOS Stream 10, I reviewed the Google Cloud public image information and used the public image family instead of hardcoding a single image name.

The image data source uses:

```hcl
data "google_compute_image" "centos_stream_10" {
  family  = "centos-stream-10"
  project = "centos-cloud"
}
```

Using an image family allows Terraform to use the current image from that family.

### External IP Configuration

The VM receives an external IP address because the `network_interface` block includes an `access_config` block.

```hcl
network_interface {
  network = "default"

  access_config {
    # Ephemeral external IP
  }
}
```

Without the `access_config` block, the VM would only have an internal IP address.

### Two Non-Required Arguments Used

- `tags`  
  The `tags` argument is not required to create a VM, but I used it so the VM can match firewall rules for HTTP traffic. For this assignment, the tag `http-server` helps allow port 80 access when the matching firewall rule exists.

- `metadata_startup_script`  
  The `metadata_startup_script` argument is not required to create a VM, but it is useful for automation. It allows the VM to run the instructor-provided startup script when the VM boots.

### Startup Script

The assignment provided a RHEL-compatible startup script for CentOS.

Command used to download the script:

```bash
curl -o startup.sh https://raw.githubusercontent.com/aaron-dm-mcdonald/class7.5-notes/refs/heads/main/week-8/hw/startup-for-rhel.sh
```

The Terraform VM uses the script with:

```hcl
metadata_startup_script = file("${path.module}/startup.sh")
```

### Outputs

The Terraform configuration includes outputs for the internal IP, external IP, VM name, VM ID, and VM self link.

The internal IP is pulled from the VM network interface:

```hcl
google_compute_instance.week8_vm.network_interface[0].network_ip
```

The external IP is pulled from the VM access configuration:

```hcl
google_compute_instance.week8_vm.network_interface[0].access_config[0].nat_ip
```

Required outputs:

```hcl
output "vm_internal_ip" {
  description = "Internal IP address of the VM"
  value       = google_compute_instance.week8_vm.network_interface[0].network_ip
}

output "vm_external_ip" {
  description = "External IP address of the VM"
  value       = google_compute_instance.week8_vm.network_interface[0].access_config[0].nat_ip
}

output "vm_name" {
  description = "Name of the VM"
  value       = google_compute_instance.week8_vm.name
}

output "vm_id" {
  description = "ID of the VM"
  value       = google_compute_instance.week8_vm.id
}

output "vm_self_link" {
  description = "Self link of the VM"
  value       = google_compute_instance.week8_vm.self_link
}
```

### Difference Between `name`, `id`, and `self_link`

- `name`  
  The `name` argument is the name assigned in the Terraform code. It is the readable VM name shown in the Google Cloud Console.

- `id`  
  The `id` attribute is computed after the VM is created. Terraform and the provider use it to track the real cloud resource.

- `self_link`  
  The `self_link` attribute is the full Google Cloud URI for the VM. It is useful when another resource or output needs the full path to the VM instead of only the short name.

### Terraform Commands Used

```bash
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
terraform output
```

### Troubleshooting Note

During testing, the first VM creation attempt failed because the selected Google Cloud zone did not have enough capacity for the selected `n1-standard-1` machine type. This was a Google Cloud resource availability issue, not a Terraform syntax issue. The issue was resolved by changing to another zone and rerunning Terraform.

---

## Screenshots and Validation

Screenshots are stored in the `screenshots/` folder.

### ClickOps MIG Screenshots

```text
screenshots/clickops-mig/
```

Recommended screenshots:

- Instance template created
- Managed instance group created
- Autoscaling enabled
- Autohealing health check configured
- Managed instances distributed across zones
- VM showing it is managed by the instance group

### Terraform VM Screenshots

```text
screenshots/terraform-vm/
```

Recommended screenshots:

- `terraform fmt`
- `terraform init`
- `terraform validate`
- `terraform plan`
- `terraform apply`
- `terraform output`
- VM created in Google Cloud
- Browser or curl test to the VM external IP

---

## Git and State File Protection

The `.gitignore` file prevents local Terraform files from being committed.

```gitignore
.terraform/
*.tfstate
*.tfstate.*
crash.log
crash.*.log
*.tfvars
*.tfvars.json
```

Terraform state files should not be committed because they can contain environment-specific and sensitive information. The `.terraform/` directory should not be committed because it contains downloaded provider binaries that can be recreated with `terraform init`.

---

## Final Validation

Before submission, the following commands should run successfully from the Terraform directory:

```bash
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
terraform output
```

The final Terraform output should show:

- VM internal IP
- VM external IP
- VM name
- VM ID
- VM self link

---

## Author

**Ervgotti3**
