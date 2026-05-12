# Week 8 Homework

## Documentation and Resources Used

Instance Groups

* Google Cloud Instance Groups Documentation is used to understand the difference between managed and unmanaged instance groups, and to      identify which MIG features support autoscaling, autohealing, and multi-zone availability.
https://docs.cloud.google.com/compute/docs/instance-groups#managed\_instance\_groups
https://cloud.google.com/instance-groups?hl=en

Load Balancing

* Google Cloud Load Balancing Documentation  
Used to understand how load balancers use backend health checks to decide whether traffic should be sent to a VM.
https://cloud.google.com/load-balancing?hl=en
https://docs.cloud.google.com/load-balancing/docs/application-load-balancer
https://docs.cloud.google.com/load-balancing/docs/https
https://docs.cloud.google.com/load-balancing/docs/application-load-balancer#three-tier\_web\_services
https://levelup.gitconnected.com/load-balancing-on-google-cloud-platform-gcp-why-and-how-a8841d9b70c



Solutions Architecture
https://docs.cloud.google.com/architecture/infra-reliability-guide/design



# Q\&A (Questions and Answers)

\#1 What is the difference between high availability and fault tolerance? Answer: HA is used when the infrastructure needs to be available 24/7 and reducing downtime through redundancy and recovery, while fault tolerance means the system keeps working even when a component fails with little or no interruption. In most cases, high availability is usually preferred practical goal because full fault tolerance can be more complex and expensive.



\#2 Explain the difference between autoscaling and elasticity. What is vertical and horizontal autoscaling? Is one better? Are they feasible on prem? Answer: autoscaling vs elasticity, autoscaling adds or removes resources based on conditions like CPU utilization or load. Elasticity is used for expanding and shrinking resources as demand changes. Horizontal scaling adds more VMs; vertical scaling increases the size of an existing VM. Horizontal scaling is usually better for cloud-native web workloads because it avoids relying on one large server, but vertical scaling can still be useful for workloads that cannot easily be split across multiple servers.



\#3 Explain what the difference between managed and unmanaged instance groups is. 

Answer: Managed instance groups (MIGs) let you operate apps on multiple identical VMs. You can make your workloads scalable and highly             available by taking advantage of automated MIG services, including: autoscaling, autohealing, regional (multiple zone) deployment, and automatic updating.



\#4 Explain the different use cases for health checks used by applications (in instance groups) and health checks used by load balancers. Can they be the same? Are they different API calls? Should they be the same? 

Answer: health check is used to decide whether a VM should be recreated, while a load balancer health check is used to decide whether traffic should be sent to a backend. They can check the same application endpoint, like HTTP port 80, but they do not have to be identical because the operational purpose is different. Google describes health checks as probes used to determine whether backends are healthy enough to receive traffic, and health checks also support application-based autohealing for Managed Instance Grp



\#5 Explain in a few sentences what the 3 tier architecture is and how it relates to what you are learning?

Answer:the web tier can use an external Application Load Balancer, the application tier can use internal load balancing and instance groups, and the database tier can be separated behind internal networking/load balancing.



## Runbook



End Goal:

Create a fully configured Google Cloud managed instance group using the console. The managed instance group should use an instance template, support autohealing, support autoscaling, and distribute managed VM instances across multiple zones.



\## Prerequisites



\- Access to a Google Cloud project with Compute Engine enabled.

\- IAM permissions to create instance templates, managed instance groups, firewall rules, and health checks.

\- A VPC/subnet selected before starting.

\- A startup script or image that installs/runs the application.

\- A firewall rule that allows the application port and allows health check probes.



\## Step 1 - Create the Instance Template



1\. Go to Compute Engine > Instance templates.

2\. Create a new instance template.

3\. Select the machine type, boot disk image, network, subnet, firewall tags, and startup script.

4\. Save the template.



\## Step 2 - Create the Managed Instance Group



1\. Go to Compute Engine > Instance groups.

2\. Select Create instance group.

3\. Choose New managed instance group.

4\. Select the instance template.

5\. Choose Regional if the group should run across multiple zones.

6\. Select the region and zones.

7\. Set the initial number of instances.



\## Step 3 - Enable Autoscaling



1\. In the managed instance group settings, enable autoscaling.

2\. Set the minimum and maximum number of instances.

3\. Choose a scaling signal, such as CPU utilization.

4\. Set the target utilization value.

5\. Save the configuration.



\## Step 4 - Enable Autohealing



1\. Create or select an HTTP/TCP health check.

2\. Attach the health check to the managed instance group autohealing policy.

3\. Set an initial delay long enough for the VM startup script and application service to finish starting.

4\. Save the configuration.



\## Step 5 - Verify Multi-Zone Management



1\. Open the managed instance group details page.

2\. Confirm the location type is Regional.

3\. Review the listed zones.

4\. Confirm that managed instances are distributed across more than one zone.

5\. If all instances are in one zone, review the distribution shape and selected zones.



## Terraform

## How to Run the Terraform Code

