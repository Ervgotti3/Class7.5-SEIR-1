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

\---

## Repository Structure

> Update this section as folders/files are added.

```text
.
├── README.md
├── infra/                  # Terraform configuration files
│   ├── provider.tf
│   ├── vpc.tf
│   ├── local\_file.tf
│   ├── outputs.tf
│   └── .gitignore
├── screenshots/            # Terraform workflow screenshots
└── notes/                  # Study notes or command references
```

\---

## Weekly Assignment Timeline

|Week|Assigned|Due|Main Focus|Status|
|-|-:|-:|-|-|
|Week 1|Fri 3/13/26|Thu 3/19/26|Group setup and install document|Completed / Review|
|Week 2|Fri 3/20/26|Thu 3/26/26|Deploy VM with `supera.sh` and verify with gate script|Completed / Review|
|Week 3|Fri 3/27/26|Thu 4/2/26|Udemy labs, Terraform workflow screenshots|Completed / Review|
|Week 4|Fri 4/3/26|Thu 4/9/26|Time off granted|N/A|
|Week 5|Fri 4/10/26|Thu 4/16/26|Terraform IVPAD workflow, screenshots, GitHub push|Completed / Review|
|Week 6|Fri 4/17/26|Thu 4/23/26|Catch up and continue Packt reading|Catch Up|
|Week 7|Fri 4/24/26|Thu 4/30/26|Terraform + GCP VPC + local file resource|In Progress|
|Week 8|Fri 5/1/26|Thu 5/7/26|Instance groups, load balancing, architecture|Upcoming|
|Week 9|Fri 5/8/26|Thu 5/14/26|Pending|Pending|
|Week 10|Fri 5/15/26|Thu 5/21/26|Pending|Pending|
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

## Week 8 Study Topics

### Udemy

* Masterclass: Section 11
* Terraform: Section 7

### Books

**Packt**

* Review Chapter 4 on:

  * Instance groups
  * Templates
  * Autohealing
  * Autoscaling
* Chapter 10

**Terraform**

* Chapters 3–4

\---

### Documentation

#### Instance Groups

* [Managed instance groups](https://docs.cloud.google.com/compute/docs/instance-groups#managed_instance_groups)
* [Google Cloud instance groups overview](https://cloud.google.com/instance-groups?hl=en)

#### Load Balancing

* [Google Cloud Load Balancing](https://cloud.google.com/load-balancing?hl=en)
* [Application Load Balancer documentation](https://docs.cloud.google.com/load-balancing/docs/application-load-balancer)
* [HTTPS Load Balancing](https://docs.cloud.google.com/load-balancing/docs/https)
* [Three-tier web services with Application Load Balancer](https://docs.cloud.google.com/load-balancing/docs/application-load-balancer#three-tier_web_services)
* [Load Balancing on GCP: Why and How](https://levelup.gitconnected.com/load-balancing-on-google-cloud-platform-gcp-why-and-how-a8841d9b70c)

#### Solutions Architecture

* [Infrastructure reliability design guide](https://docs.cloud.google.com/architecture/infra-reliability-guide/design)

\---

## Pending Assignments

|Week|Dates|Status|
|-|-|-|
|Week 9|Fri 5/8/26 – Thu 5/14/26|Pending|
|Week 10|Fri 5/15/26 – Thu 5/21/26|Pending|
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

