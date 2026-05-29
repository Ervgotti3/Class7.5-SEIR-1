# Class 7.5 SEIR-1 — Homework \& Lab Tracker

## Overview

This repository tracks homework, lab work, Terraform practice, Google Cloud Platform exercises, screenshots, and supporting notes for **Class 7.5 SEIR-1**.

The work in this repo focuses on:

* Terraform fundamentals and workflow practice
* Google Cloud Platform infrastructure deployments
* Git and GitHub repository management
* Linux command-line practice
* Documentation, screenshots, and lab deliverables

\---

## Quick Navigation

|Section|Description|
|-|-|
|[Weekly Assignment Timeline](#weekly-assignment-timeline)|High-level overview of each assigned week|
|[Terraform IVPAD Workflow](#terraform-ivpad-workflow)|Terraform init, validate, plan, apply, destroy|
|[Week 5 Deliverables](#week-5-deliverables)|Week 5 screenshot and GitHub submission requirements|
|[Week 7 Deliverables](#week-7-deliverables)|GCP VPC, local file, output block, and README requirements|
|[Week 7 Be A Man Lab](#week-7-be-a-man-lab)|Static website POC using GCS|
|[Week 8 Study Topics](#week-8-study-topics)|Instance groups, load balancing, and architecture links|
|[Week 9 Deliverables](#week-9-deliverables--global-load-balancing-cloud-armor-and-cloud-cdn)|Cloud NAT, global load balancing, Cloud Armor, Cloud CDN, and Terraform ALB|
|[Week 10 Deliverables](#week-10-deliverables--dns-ssltls-https-load-balancing-and-troubleshooting)|DNS, SSL/TLS, Cloud DNS, HTTPS load balancing, and troubleshooting|
|[Week 11 Assignment](#week-11-assignment)|Pending Week 11 assignment section|
|[Week 12 Assignment](#week-12-assignment)|Pending Week 12 assignment section|


\---

## Repository Structure

> Update this section as folders/files are added.

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

## Weekly Assignment Timeline

|Week|Assigned|Due|Main Focus|Status|
|-|-:|-:|-|-|
|Week 1|Fri 3/13/26|Thu 3/19/26|Group setup and install document|Completed / Review|
|Week 2|Fri 3/20/26|Thu 3/26/26|Deploy VM with `supera.sh` and verify with gate script|Completed / Review|
|Week 3|Fri 3/27/26|Thu 4/2/26|Udemy labs, Terraform workflow screenshots|Completed / Review|
|Week 4|Fri 4/3/26|Thu 4/9/26|Time off granted|N/A|
|Week 5|Fri 4/10/26|Thu 4/16/26|Terraform IVPAD workflow, screenshots, GitHub push|Completed / Review|
|Week 6|Fri 4/17/26|Thu 4/23/26|Catch up and continue Packt reading|Catch Up|
|Week 7|Fri 4/24/26|Thu 4/30/26|Terraform + GCP VPC + local file resource|Completed / Review|
|Week 8|Fri 5/1/26|Thu 5/7/26|Instance groups, load balancing, architecture|Completed / Review|
|Week 9|Fri 5/8/26|Thu 5/14/26|Cloud NAT, Global load balancing, Cloud CDN|Completed / Review|
|Week 10|Fri 5/15/26|Thu 5/15/26|DNS background, SSL/TLS background, Load Balancers, Cloud Domain/DNS|Completed / Review|
|Week 11|Fri 5/22/26|Thu 5/28/26|Pending|Pending|
|Week 12|Fri 5/29/26|Thu 6/4/26|Pending|Pending|

\---

## Terraform IVPAD Workflow

The Terraform workflow used throughout the assignments follows the **IVPAD** sequence:

|Step|Command|Purpose|
|-|-|-|
|Init|`terraform init`|Initializes the working directory and downloads providers|
|Validate|`terraform validate`|Checks whether the configuration syntax is valid|
|Plan|`terraform plan`|Shows what Terraform will create, modify, or destroy|
|Apply|`terraform apply`|Builds the infrastructure|
|Destroy|`terraform destroy`|Tears down the infrastructure|

After destroy, run:

```bash
date \&\& hostname \&\& whoami
```

This confirms the system, user, and time after the resources have been removed.

\---

## Week 1 Assignment

**Task:**  
Get in a group and finish the installs document.

\---

## Week 2 Assignment

**Task:**  
Deploy a VM instance using the `supera.sh` script.

**Validation:**  
Check successful deployment using the provided **gate** script.

\---

## Week 3 Assignment

**Homework Document:**  
Review `homework.md`.

**Udemy Work:**

* Masterclass: Section 10
* Security: Section 13

**Deliverables:**

* Completed Udemy labs
* Screenshots of the full Terraform workflow

\---

## Week 4 Assignment

**Status:**  
N/A — Time off granted by Theo.

**Reason:**  
Birthday week and Illinois in NCAA Final Four.

\---

## Week 5 Deliverables

### Reading, Videos, and Labs

**Udemy**

* Masterclass: Sections 5–6

**Books**

* Packt: Chapters 1–4 and Chapter 8
* Terraform: Chapters 1–2

**Linux**

* TLCL: Chapters 1–4
* KCLinux: Lessons 1–8

**Git**

* LG: Chapters 1–3
* KCG: Lessons 1–4

\---

### Class Practice

**Task:**  
Re-run the in-class lab from Friday and Saturday’s recordings.

**Requirement:**  
Take screenshots throughout the Terraform IVPAD workflow showing the output of each command.

### Required Screenshots

* \[ ] `terraform init`
* \[ ] `terraform validate`
* \[ ] `terraform plan`
* \[ ] `terraform apply`
* \[ ] `terraform destroy`
* \[ ] `date \&\& hostname \&\& whoami`

\---

### Be A Man Extra Credit

**Task:**  
Use the Terraform files from this week's classes.

**Requirements:**

* Export the Terraform plan output into a file
* Create a new folder in Terminal/Git Bash named:

```text
<insertDateHere>\_weekB\_hw
```

* Move the Terraform plan output into that folder
* Use Git to push the Terraform plan output to GitHub
* The GitHub repository must start with:

```text
TheoU\_7.5\_BaM\_weekB
```

### Extra Credit Deliverables

* \[ ] Same Terraform workflow screenshots listed above
* \[ ] Terraform plan output in `.txt` or `.json` format
* \[ ] Student GitHub repository link

\---

## Week 6 Assignment

**Focus:**  
Catch up on unfinished work.

**Suggestion from Aaron:**  
Keep reading daily in the PCA Packt book and make sure the prior week’s work is complete.

\---

## Week 7 Deliverables

### Readings, Videos, and Labs

**Udemy**

* Terraform: Sections 1–4

  * Speed through Section 1
  * Terraform is already installed
  * Service accounts, environment variables, and Cloud Shell are not used for authentication
  * Authentication follows the method shown in video 25 for the Google provider
* Terraform: Section 6

\---

### Main Lab Requirement

Create a new GitHub repository containing Terraform code.

**Repository requirements:**

* New repository created by the student
* README explaining:

  * How the lab was completed
  * Documentation used
  * Resources used
  * Issues encountered
* Screenshot of successful Terraform deployment showing:

  * Terraform output
  * File created by Terraform

\---

### Terraform Requirements

Place the Terraform code in a folder named one of the following:

* `infra`
* `terraform`
* Another similar folder name

The Terraform code must include:

* \[ ] Google provider configuration using the latest provider version
* \[ ] GCP VPC configuration using example code from the Terraform Registry
* \[ ] No remote backend required
* \[ ] `.gitignore` file included
* \[ ] `local\_file` resource that creates a text file containing favorite food
* \[ ] Output block showing the VPC name in GCP

\---

## Week 7 Be A Man Lab

### Study Order

Complete these in order:

1. Masterclass: Section 7
2. Security: Videos 31–33
3. Terraform: Section 5

\---

### Lab Goal

Deploy a proof-of-concept static website that is fully automated using:

* Google Cloud Storage bucket
* Sample static assets provided by the instructor
* One image of your choice
* Terraform automation

\---

### Be A Man Repository Requirements

The repository is the only item to submit.

It must include:

* \[ ] Repository description
* \[ ] Terraform configuration files (`\*.tf`)
* \[ ] Latest Google provider version
* \[ ] Current code from the latest documentation where appropriate
* \[ ] Comments written by the student
* \[ ] README file checked into the repo

\---

### Be A Man README Requirements

The README should include:

* \[ ] Static website URL
* \[ ] Explanation of what the lab is
* \[ ] What the lab accomplishes
* \[ ] Pros and cons
* \[ ] Lessons learned
* \[ ] Documentation used
* \[ ] Any resources used
* \[ ] Issues encountered
* \[ ] Optional clickable bucket URL from Terraform output

\---

## Week 8 Deliverables — Managed Instance Groups, Load Balancing, and Terraform

### Status

**In Progress / Final Review**

### Study Topics Completed

**Udemy**

* Masterclass: Section 11
* Terraform: Section 7

**Books**

**Packt**

* Reviewed Chapter 4 topics on instance groups, instance templates, autohealing, and autoscaling
* Chapter 10

**Terraform**

* Chapters 3–4

\---

## Documentation and Resources Used

The following documentation and resources were used to complete the Week 8 assignment. I used the documentation to understand the concepts, compare the services, and confirm the correct Terraform and Google Cloud configuration options.

### Instance Groups

* [Managed instance groups](https://docs.cloud.google.com/compute/docs/instance-groups#managed_instance_groups)  
  Used to understand what managed instance groups are, how they differ from unmanaged instance groups, and how they support autoscaling, autohealing, and multi-zone deployments.

* [Google Cloud instance groups overview](https://cloud.google.com/instance-groups?hl=en)  
  Used to review the main use cases for instance groups and how Google Cloud manages groups of VM instances.

### Load Balancing

* [Google Cloud Load Balancing](https://cloud.google.com/load-balancing?hl=en)  
  Used to understand why load balancing is used and how it distributes traffic across backend resources.

* [Application Load Balancer documentation](https://docs.cloud.google.com/load-balancing/docs/application-load-balancer)  
  Used to understand how application load balancers fit into web application architectures.

* [HTTPS Load Balancing](https://docs.cloud.google.com/load-balancing/docs/https)  
  Used to review how HTTPS load balancing works and how it relates to frontend traffic management.

* [Three-tier web services with Application Load Balancer](https://docs.cloud.google.com/load-balancing/docs/application-load-balancer#three-tier_web_services)  
  Used to understand how web, application, and database tiers can be separated in a cloud architecture.

* [Load Balancing on GCP: Why and How](https://levelup.gitconnected.com/load-balancing-on-google-cloud-platform-gcp-why-and-how-a8841d9b70c)  
  Used as a secondary explanation to reinforce the load balancing concepts from the Google documentation.

### Solutions Architecture

* [Infrastructure reliability design guide](https://docs.cloud.google.com/architecture/infra-reliability-guide/design)  
  Used to compare high availability, reliability, redundancy, and failure recovery design concepts.

### Terraform and VM Image Documentation

* [Terraform Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest)  
  Used to confirm the provider source and current provider documentation for Google Cloud resources.

* [Google Cloud OS image details](https://docs.cloud.google.com/compute/docs/images/os-details)  
  Used to confirm that CentOS Stream 10 is available from the `centos-cloud` image project with the `centos-stream-10` image family.

\---

## Q & A

### What is the difference between high availability and fault tolerance? Which is best to strive for?

High availability means designing a system so it stays online as much as possible by using redundancy, multiple zones, health checks, and recovery processes. Fault tolerance goes further because the system should continue operating even when a component fails, with little or no interruption. In most cloud infrastructure designs, high availability is the better practical goal because it balances uptime, cost, and complexity. Full fault tolerance is useful for critical workloads, but it can be more expensive and harder to design correctly.

### Explain the difference between autoscaling and elasticity. What is vertical and horizontal autoscaling? Is one better? Are they feasible on prem?

Autoscaling is the actual mechanism that adds or removes compute resources based on demand, such as CPU usage or load balancer traffic. Elasticity is the broader cloud capability of growing and shrinking resources as workload demand changes. Vertical scaling means increasing the size of one machine, such as moving from a smaller VM to a larger VM. Horizontal scaling means adding more machines, such as adding more VM instances to a managed instance group. Horizontal scaling is usually better for cloud web applications because it avoids depending on one large server, but vertical scaling can still be useful for workloads that cannot easily be split across multiple systems. These ideas are possible on premises, but they are harder because hardware capacity must already be purchased, installed, and available.

### Explain what the difference between managed and unmanaged instance groups is.

A managed instance group uses an instance template so Google Cloud can create and manage similar VM instances as a group. Managed instance groups support features like autoscaling, autohealing, rolling updates, and regional multi-zone distribution. An unmanaged instance group is a collection of VM instances that an engineer manages more manually. Unmanaged groups may still be useful for load balancing existing VMs, but they do not provide the same automation features as managed instance groups.

### Explain the different use cases for health checks used by applications in instance groups and health checks used by load balancers. Can they be the same? Are they different API calls? Should they be the same?

A managed instance group health check is commonly used for autohealing. If the VM or application fails the health check, the managed instance group can recreate the VM. A load balancer health check is used to decide whether traffic should be sent to a backend instance. They can check the same port and path, such as HTTP port 80, but they serve different purposes. They are configured through Google Cloud health check resources/API calls and can reuse the same health check object in some designs, but they do not always need to be identical. In production, the health check should match the goal: autohealing checks should confirm the instance is broken before replacing it, while load balancer checks should confirm the backend is ready to receive traffic.

### Explain in a few sentences what the 3-tier architecture is and how it relates to what you are learning.

A three-tier architecture separates an application into a web tier, application tier, and database tier. The web tier handles user traffic, the application tier processes business logic, and the database tier stores data. This relates to instance groups and load balancing because cloud applications often use load balancers in front of web or application tiers and managed instance groups to keep those tiers scalable and highly available.

\---

## Runbook

### End Goal

Create a fully configured Google Cloud managed instance group using ClickOps in the Google Cloud Console. The managed instance group should use an instance template, support autoscaling, use autohealing, and manage VM instances across multiple zones. The goal is for another engineer to follow this runbook and build a properly configured managed instance group without needing extra explanation.

### Prerequisites

Before starting, confirm the following items are ready:

* Access to a Google Cloud project with Compute Engine enabled.
* IAM permissions to create instance templates, managed instance groups, health checks, and firewall rules.
* A selected region and at least two zones for regional availability.
* A VPC and subnet selected for the VM instances.
* A startup script or image that installs and starts the application service.
* A firewall rule or network tag that allows application traffic, such as HTTP port 80.
* A firewall rule that allows Google Cloud health check probe traffic.
* Naming standard for the instance template, managed instance group, and health check.

### Create the Instance Template

1. In the Google Cloud Console, go to **Compute Engine > Instance templates**.
2. Select **Create instance template**.
3. Enter a clear name for the template.
4. Choose the required machine type, boot disk image, and boot disk size.
5. Select the VPC and subnet.
6. Add any required network tags, such as `http-server`, if using the default HTTP firewall rule.
7. Add the startup script if the application should install and start automatically.
8. Review the configuration and create the template.

### Create the Managed Instance Group

1. Go to **Compute Engine > Instance groups**.
2. Select **Create instance group**.
3. Choose **New managed instance group**.
4. Select the instance template created earlier.
5. Choose **Regional** if the group needs to manage instances across multiple zones.
6. Select the region and confirm at least two zones are selected.
7. Set the initial number of VM instances.
8. Choose the distribution shape based on the lab or design requirement.
9. Create the managed instance group.

### Enable Autoscaling

1. Open the managed instance group settings.
2. Enable autoscaling.
3. Set the minimum number of instances.
4. Set the maximum number of instances.
5. Choose a scaling signal, such as CPU utilization.
6. Set the target utilization value.
7. Save the autoscaling configuration.

### Enable Autohealing

1. Create or select a health check for the application.
2. Attach the health check to the managed instance group autohealing policy.
3. Set an initial delay long enough for the VM startup script and application to finish starting.
4. Save the autohealing configuration.
5. Confirm the managed instance group shows healthy instances after the startup delay.

### Verify Multi-Zone Management

1. Open the managed instance group details page.
2. Confirm the location type is **Regional**.
3. Review the list of selected zones.
4. Open the **VM instances** or **Managed instances** view.
5. Confirm the group has instances running in more than one zone.
6. If all instances are in one zone, review the selected zones and distribution settings.

### Critical Configuration Notes

* Use a managed instance group when autoscaling, autohealing, and consistent VM configuration are required.
* Use a regional managed instance group when the workload should survive a single-zone issue.
* Use a startup script or golden image so every instance created by the group is configured consistently.
* Make sure the firewall allows both user/application traffic and health check probe traffic.
* Set the autohealing initial delay high enough to avoid replacing VMs while the startup script is still running.
* Keep names clear so other engineers can identify the instance template, health check, and managed instance group quickly.

### Runbook Validation Screenshots

Recommended screenshots for proof that the runbook was tested:

* Instance template created
* Managed instance group details page
* Regional or multi-zone configuration
* Autoscaling configuration enabled
* Autohealing health check attached
* Managed instances showing VM instances across zones
* Health check or backend health showing healthy, if available

\---

## Terraform

### Purpose

The Terraform portion of this assignment provisions a single Google Compute Engine VM using infrastructure as code. The VM uses CentOS Stream 10, an N-series machine type, a 100 GB root persistent disk, an external IP address, and the provided RHEL-compatible startup script.

The Terraform configuration is stored in the `terraform/` subdirectory and should be able to run with the following commands:

```bash
terraform init
terraform validate
terraform apply
```

### Terraform Directory Structure

```text
terraform/
├── .gitignore
├── 00-versions.tf
├── 01-provider.tf
├── 02-variables.tf
├── 03-data.tf
├── 04-firewall.tf
├── 05-vm.tf
├── 06-outputs.tf
└── startup.sh
```

### Required VM Arguments in Terraform

For the `google_compute_instance` resource, the main required arguments are:

* `name`  
  The name assigned to the VM. This is the human-readable name that appears in Google Cloud.

* `machine_type`  
  The machine family and size for the VM. For this assignment, I used an N-series machine type.

* `zone`  
  The Google Cloud zone where the VM is created.

* `boot_disk`  
  The boot disk configuration for the VM. I used this block to define the CentOS Stream 10 image and set the root persistent disk to 100 GB.

* `network_interface`  
  The network configuration for the VM. I used the default VPC and included an external access configuration so the VM receives an external IP.

### CentOS Stream 10 Image Format

To figure out the correct image format, I reviewed the Google Cloud OS image documentation. The documentation lists CentOS Stream 10 under the `centos-cloud` image project with the `centos-stream-10` image family.

Instead of hardcoding a single image version, I used a Terraform data source to reference the image family:

```hcl
data "google_compute_image" "centos_stream_10" {
  family  = "centos-stream-10"
  project = "centos-cloud"
}
```

The VM then references the image from the data source:

```hcl
boot_disk {
  initialize_params {
    image = data.google_compute_image.centos_stream_10.self_link
    size  = 100
  }
}
```

### External IP Address

The VM receives an external IP address because the `network_interface` block includes an `access_config` block:

```hcl
network_interface {
  network = "default"

  access_config {
    # Ephemeral external IP
  }
}
```

Without the `access_config` block, the VM would only receive an internal IP address.

### Two Non-Required Arguments Used

* `tags`  
  The `tags` argument is not required to create a VM, but I used it so the VM can match a firewall rule for HTTP traffic. For this lab, the `http-server` tag is useful because it allows port 80 traffic when the matching firewall rule exists.

* `metadata_startup_script`  
  The `metadata_startup_script` argument is not required to create a VM, but I used it to run the provided startup script when the VM is created. This makes the VM configure itself automatically after boot.

### Startup Script

The assignment provided a startup script designed for RHEL-based systems. Since CentOS Stream is related to RHEL, this script is more appropriate than a Debian or Ubuntu-based startup script.

The script was downloaded with:

```bash
curl -o startup.sh https://raw.githubusercontent.com/aaron-dm-mcdonald/class7.5-notes/refs/heads/main/week-8/hw/startup-for-rhel.sh
```

The script is referenced in Terraform with:

```hcl
metadata_startup_script = file("${path.module}/startup.sh")
```

### Outputs

The Terraform configuration outputs the internal IP address, external IP address, VM name, VM ID, and VM self link.

I figured out the IP output format by reviewing the attributes exposed by the `google_compute_instance` resource. The internal IP comes from the first network interface, and the external IP comes from the first access configuration on that network interface.

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
  description = "Computed ID of the VM"
  value       = google_compute_instance.week8_vm.id
}

output "vm_self_link" {
  description = "Self link URI of the VM"
  value       = google_compute_instance.week8_vm.self_link
}
```

### Difference Between `name`, `id`, and `self_link`

* `name`  
  The `name` argument is the readable name I assign to the VM in Terraform.

* `id`  
  The `id` attribute is computed after the resource is created. Terraform and the provider use it to track the actual Google Cloud resource.

* `self_link`  
  The `self_link` attribute is the full URI path to the VM resource in Google Cloud. It is useful when another resource or output needs the complete reference instead of only the short name.

### Terraform Commands Used

```bash
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
terraform output
```

* `terraform fmt` formats the Terraform files using the standard Terraform style.
* `terraform init` initializes the working directory and downloads the Google provider.
* `terraform validate` checks whether the configuration is valid.
* `terraform plan` previews what Terraform will create.
* `terraform apply` creates the VM.
* `terraform output` displays the required values after the VM is created.

### Troubleshooting Note

During the first Terraform apply, the VM failed to create because the selected zone did not have enough available capacity for the `n1-standard-1` machine type. This was a temporary Google Cloud resource availability issue, not a Terraform syntax issue. I resolved the issue by changing the VM zone to another zone in the same region and rerunning Terraform.

### State File and Provider Directory Protection

The `.gitignore` file prevents local Terraform files from being committed to GitHub.

```gitignore
.terraform/
*.tfstate
*.tfstate.*
crash.log
crash.*.log
*.tfvars
*.tfvars.json
```

Terraform state files should not be committed because they can contain environment-specific or sensitive information. The `.terraform/` directory should not be committed because it contains downloaded provider files that can be recreated with `terraform init`.

### Terraform Validation Screenshots

Recommended Terraform screenshots for this assignment:

* `terraform fmt`
* `terraform init`
* `terraform validate`
* `terraform plan`
* `terraform apply`
* `terraform output`
* Google Cloud VM details showing CentOS Stream 10
* Google Cloud VM details showing 100 GB boot disk
* Google Cloud VM details showing the external IP address
* Browser or curl test to the external IP address

\---

## Week 8 Final Submission Checklist

* [ ] Week 8 README section completed
* [ ] Documentation and resources listed with how they were used
* [ ] Q & A section completed
* [ ] Runbook section completed
* [ ] Runbook tested by a group mate, if possible
* [ ] ClickOps managed instance group screenshots added
* [ ] Terraform code placed in the `terraform/` subdirectory
* [ ] Terraform `.gitignore` included
* [ ] No `.terraform/` directory committed
* [ ] No `.tfstate` files committed
* [ ] Terraform code runs with `terraform init`, `terraform validate`, and `terraform apply`
* [ ] VM uses CentOS Stream 10
* [ ] VM has an external IP address
* [ ] Root persistent disk is 100 GB
* [ ] Machine type is in the N series
* [ ] Outputs include internal IP, external IP, name, ID, and self link
* [ ] Final changes committed and pushed to GitHub

## Week 9 Deliverables — Global Load Balancing, Cloud Armor, and Cloud CDN

### Status

**Completed / Review**

### Readings, Videos, and Labs

**Udemy**

* Masterclass: Section 12
* Security: Section 21

**Books**

* Packt: Chapter 5
* Terraform: Chapters 5–6

---

### Documentation and Background Topics

The Week 9 assignment focused on the following documentation and background areas:

**Cloud NAT**

* Private NAT / Google Cloud NAT documentation
* Cloud NAT explained
* Public and private subnet concepts in Google Cloud

**Global Load Balancing**

* Global external HTTPS load balancer setup
* Deep dive on global external HTTPS load balancing

**Cloud CDN**

* CDN concepts
* Google Cloud CDN product documentation
* Cloud CDN overview and general documentation

**Cloud Armor**

* Web Application Firewall basics
* Cloud Armor product overview
* Cloud Armor documentation overview
* Rate-based rules and Layer 7 protection concepts
* reCAPTCHA and bot management concepts

---

### Assignment Requirements

The Week 9 assignment required a README with documentation/resources used and a Q&A section written for a junior cloud infrastructure employee. The Q&A covered load balancing, Cloud Armor, and Cloud CDN concepts.

### Q&A Topics

**Load Balancers**

* How load balancing contributes to fault tolerance and high availability
* Whether global load balancers decrease latency for end users
* What load balancer health checks are used for
* Whether health checks are always needed
* Difference between a load balancer and a reverse proxy
* Routing rules and URL maps
* Anycast IP addresses in global load balancing

**Cloud Armor**

* What Cloud Armor offers
* Why Cloud Armor is used
* What OSI layer Cloud Armor operates at
* How Cloud Armor differs from VPC firewall rules
* Rate-based rules
* reCAPTCHA and bot management

**Cloud CDN**

* What POPs are used for
* What files are commonly served through Cloud CDN
* Supported Cloud CDN origins
* How Cloud CDN can help reduce certain malicious traffic patterns
* Whether an enterprise should always use Cloud CDN
* TTL and content freshness

---

### Group Work — Runbook

The group work required a runbook section for creating a fully configured external Application Load Balancer through ClickOps.

The runbook covered:

* End goal
* Prerequisites
* Creating an external Application Load Balancer
* Using a managed instance group as the backend
* Health check configuration
* Backend service configuration
* URL map and routing rules
* Frontend configuration
* Key settings and validation steps

---

### Terraform Requirements

The Week 9 Terraform work required a `terraform/` subdirectory with normal Terraform best practices.

Required items included:

* `.gitignore`
* No state files committed
* No lock files committed
* No `.terraform/` provider directory committed
* Terraform code that can be cloned and run with `terraform init`, `terraform validate`, and `terraform apply`
* Terraform block with version requirements
* Google provider block
* Numbered/logical file structure
* Custom VPC
* Firewall rules using target tags
* Managed instance group
* Health check
* Global external Application Load Balancer
* Informative outputs
* Student-written comments and documentation

---

### Be A Man Tasks

**Be A Man 1**

Create a Terraform configuration to deploy an external global load balancer building on the Week 9 Terraform assignment.

**Be A Man 2**

Create two backend services named:

* `colombia`
* `thailand`

Configure path-based routing so that:

* `/colombia` routes to the Colombia backend
* `/thailand` routes to the Thailand backend

The deployment also considered Cloud CDN and relevant notes.

---

## Week 10 Deliverables — DNS, SSL/TLS, HTTPS Load Balancing, and Troubleshooting

### Status

**Completed / Review**

### Readings, Videos, and Labs

**Udemy**

* Masterclass: Sections 7, 8, and 9
* Security: Nothing assigned
* Terraform: Section 12

**Books**

* Packt: Chapters 11–12
* Terraform: Nothing assigned

---

### Documentation and Background Topics

The Week 10 assignment focused on DNS, SSL/TLS, Cloud DNS, HTTPS load balancing, certificates, and troubleshooting.

**DNS Background**

* How DNS works
* DNS records
* Traceroute / tracert
* What DNS is and how it supports internet communication

**SSL/TLS Background**

* SSL, TLS, HTTP, and HTTPS
* HTTP vs. HTTPS
* How SSL/TLS encryption works
* TLS handshake concepts

**Google Cloud Documentation**

* Target proxies overview
* SSL policies
* SSL certificates
* Managed TLS certificates for HTTP(S) load balancers
* Cloud DNS overview
* Certificate Manager overview
* Encryption from the load balancer to the backend

---

### Assignment Requirements

The Week 10 assignment required a README with documentation/resources used and a Q&A section written for a junior cloud infrastructure employee.

### Q&A Topics

**DNS and SSL/TLS**

* Difference between `traceroute` and `dig`
* Common DNS records and use cases
* TLS handshake overview
* How an SSL/TLS certificate knows which domain it belongs to
* What a certificate authority is

**Load Balancers**

* How GCP Application Load Balancers offload/decrypt SSL
* What part of the load balancer handles SSL offload
* When in-flight encryption from the backend service to the backend may be needed

**Cloud Domain/DNS**

* Whether multiple domains can point to the same load balancer
* What zones are in Cloud DNS

---

### Group Work — Anti-Drunk Engineer Runbook

The Week 10 group work required a troubleshooting runbook for a broken Google Cloud VM environment.

The broken environment was created with:

```bash
curl -s https://storage.googleapis.com/static-site-bucket-522479235074/broken-env-with-prechecks-v2.sh | bash
```

The troubleshooting runbook documented:

* Initial symptoms
* VM status checks
* External IP checks
* Firewall rule checks
* Network tag checks
* Route and VPC/subnet checks
* SSH access troubleshooting
* IAP SSH troubleshooting
* Serial console logs
* Web server status
* Listening ports
* Startup script behavior
* Root cause
* Resolution
* Validation steps
* Partner testing notes

A support ticket was also created to document:

* What was happening when the issue was first observed
* Expected behavior
* Troubleshooting performed
* Root cause
* Resolution
* Reference to the anti-drunk engineer runbook

---

### Terraform Requirements

The Week 10 Terraform work required a `terraform/` subdirectory following normal Terraform practices.

Required items included:

* `.gitignore`
* VPC
* Firewall rules
* VM template
* Health check
* Managed instance group
* Global Application Load Balancer using HTTP
* Variables where appropriate
* Locals
* `terraform.tfvars`
* Outputs
* No committed state files
* No committed provider binaries
* No committed `.terraform/` directory

---

### Be A Man Tasks

**Be A Man 1**

Create a global external Application Load Balancer with Terraform.

Additional requirements:

* Create a frontend with HTTP and HTTPS
* Configure certificate information
* Use managed zone information
* Consider using data sources

**Be A Man 2**

Create a global external Application Load Balancer with three backend buckets and path-based routing rules.

This task was intentionally skipped.

---

## Week 11 Assignment

### Status

**Pending**

Week 11 assignment details have not been added yet.

Planned items to document when assigned:

* Readings, videos, and labs
* Documentation/resources used
* README requirements
* Q&A requirements
* Terraform requirements
* Runbook or troubleshooting requirements
* Validation/testing notes
* Final checklist

---

## Week 12 Assignment

### Status

**Pending**

Week 12 assignment details have not been added yet.

Planned items to document when assigned:

* Readings, videos, and labs
* Documentation/resources used
* README requirements
* Q&A requirements
* Terraform requirements
* Runbook or troubleshooting requirements
* Validation/testing notes
* Final checklist

\---

## Pending Assignments

|Week|Dates|Status|
|-|-|-|
|Week 11|Fri 5/22/26 – Thu 5/28/26|Pending|
|Week 12|Fri 5/29/26 – Thu 6/4/26|Pending|

\---

## Notes

* Keep screenshots organized by week.
* Keep Terraform code in a clean folder structure.
* Do not commit `.terraform/`, state files, or sensitive files.
* Use meaningful commit messages.
* Make sure each README section can be explained in your own words.

\---

## Example Git Commands

```bash
git status
git add .
git commit -m "Update homework README"
git push -u origin main
```

\---

## Author

**Ervgotti3**

GitHub: [Ervgotti3](https://github.com/Ervgotti3)

