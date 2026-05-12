# Week 8 Homework 

## Documentation and Resources Used

Instance Groups
- Google Cloud Instance Groups Documentation is used to understand the difference between managed and unmanaged instance groups, and to      identify which MIG features support autoscaling, autohealing, and multi-zone availability.
https://docs.cloud.google.com/compute/docs/instance-groups#managed_instance_groups
https://cloud.google.com/instance-groups?hl=en

Load Balancing 
- Google Cloud Load Balancing Documentation  
  Used to understand how load balancers use backend health checks to decide whether traffic should be sent to a VM.
https://cloud.google.com/load-balancing?hl=en
https://docs.cloud.google.com/load-balancing/docs/application-load-balancer
https://docs.cloud.google.com/load-balancing/docs/https
https://docs.cloud.google.com/load-balancing/docs/application-load-balancer#three-tier_web_services
https://levelup.gitconnected.com/load-balancing-on-google-cloud-platform-gcp-why-and-how-a8841d9b70c


Solutions Architecture
https://docs.cloud.google.com/architecture/infra-reliability-guide/design

# Q&A (Questions and Answers) 
#1 What is the difference between high availability and fault tolerance? HA is used when the infrastructure needs to be available 24/7 and reducing downtime through redundancy and recovery, while fault tolerance means the system keeps working even when a component fails with little or no interruption. In most cases, high availability is usually preferred practical goal because full fault tolerance can be more complex and expensive.


## Runbook

## Terraform

## How to Run the Terraform Code