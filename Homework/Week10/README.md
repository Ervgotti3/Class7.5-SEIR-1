\# Week 10 Assignment - DNS, SSL/TLS, HTTPS Load Balancing, and Troubleshooting



\## Overview
This Week 10 assignment focuses on DNS, SSL/TLS, HTTPS load balancing, Cloud DNS, and troubleshooting broken cloud infrastructure. The main goal is to understand how users reach cloud-hosted applications by domain name, how HTTPS protects traffic, and how Google Cloud external Application Load Balancers use certificates and frontend configuration to support secure web access.

For the hands-on Terraform portion, I built on the previous load balancer design by deploying a custom VPC, firewall rules, VM templates, managed instance groups, health checks, an external global Application Load Balancer, HTTP/HTTPS frontends, a Google-managed SSL certificate, and a Cloud DNS A record. The troubleshooting portion focuses on investigating a broken VM environment and documenting the steps in a repeatable runbook.


## Documentation and Resources Used
Udemy Masterclass Lessons 7, 8, and 9

I used these lessons to review the cloud networking and load balancing concepts covered in class. These helped me understand how DNS, HTTP/HTTPS traffic, load balancers, and backend services work together in a cloud environment.

Udemy Terraform Lesson 12

I used this lesson to reinforce Terraform structure, variables, outputs, and reusable configuration patterns. This helped me organize the Week 10 Terraform files and use a terraform.tfvars file for deployment values.


I used the following documentation, videos, and background resources to complete the Week 10 Q&A, Terraform configuration, DNS/HTTPS testing, and troubleshooting notes. These resources helped me understand DNS, SSL/TLS, Cloud DNS, Google Cloud load balancing, certificates, and encryption between the load balancer and backend services.

### DNS Background

- **How DNS Works - PowerCerts**  
  I used this video to understand the basic DNS lookup process and how domain names are translated into IP addresses.

- **DNS Records Explained**  
  I used this resource to review common DNS record types such as A, CNAME, MX, and TXT records. This helped me answer the DNS records question in the Q&A section.

- **Traceroute (tracert) Explained - Network Troubleshooting**  
  I used this resource to understand how traceroute shows the network path between a source and destination. This helped me compare `traceroute` with `dig`.

- **What is DNS? and how it makes the Internet work**  
  I used this as a high-level explanation of how DNS supports internet communication. This helped me explain DNS in a way that a junior cloud engineer could understand.

### SSL/TLS Background

- **SSL, TLS, HTTP, HTTPS Explained**  
  I used this resource to understand the difference between HTTP and HTTPS and how SSL/TLS provides encryption for web traffic.

- **HTTP vs. HTTPS: How SSL/TLS Encryption Works**  
  I used this to review how HTTPS protects data between a client and a web application. This helped me explain why certificates are needed.

- **How SSL Encryption Works**  
  I used this resource to better understand the TLS handshake process, certificate validation, and how encryption keys are established.

### GCP Load Balancing and Certificate Documentation

- **Target Proxies Overview - Cloud Load Balancing**  
  I used this documentation to understand the role of target HTTP and target HTTPS proxies in a Google Cloud external Application Load Balancer.

- **SSL Policies Concepts - Cloud Load Balancing**  
  I used this documentation to understand how SSL policies can control TLS versions and security settings for HTTPS load balancers.

- **SSL Certificates Overview - Cloud Load Balancing**  
  I used this documentation to understand how SSL certificates are attached to load balancers and how HTTPS traffic is handled at the frontend.

- **Deep Dive into Managed TLS Certs for HTTP(S) Load Balancers - Google Cloud Blog**  
  I used this blog to better understand Google-managed SSL certificates and how they are used with HTTP(S) load balancers.

- **Certificate Manager Overview - Google Cloud Documentation**  
  I used this documentation to understand Google Cloud certificate management options and how certificates are used for secure HTTPS traffic.

- **Encryption from the Load Balancer to the Backends**  
  I used this documentation to understand when traffic between the load balancer and backend instances should also be encrypted. This helped me answer the in-flight encryption question.

### Cloud DNS Documentation

- **Cloud DNS Overview**  
  I used this documentation to understand Cloud DNS managed zones, DNS records, and how Google Cloud can host DNS records for a domain.

- **Google Cloud DNS Full Course - Setup Custom Domain Step by Step**  
  I used this video as a walkthrough for connecting a custom domain to Google Cloud resources. This helped me understand how a domain can point to a load balancer IP address.

### Terraform and Class Resources

- **Week 10 Class Notes and Labs**  
  I used the class notes and lab examples as the baseline for the Terraform design and load balancer configuration. I built on the previous Week 9 Terraform work and modified it for Week 10 requirements.

- **Terraform Google Provider Documentation**  
  I used the Terraform provider documentation to verify resource arguments for VPC, subnet, firewall rules, instance templates, managed instance groups, health checks, global forwarding rules, target proxies, SSL certificates, Cloud DNS records, and outputs.

### Q&A

- **DNS and SSL/TLS**
\#### Explain what the traceroute and dig commands do. Compare and contrast.
traceroute and dig are both troubleshooting commands, but they are used for different problems.
TRACERT (Trace Route), a command-line utility that you can use to trace the path that an Internet Protocol (IP) packet takes to its destination.
Digs, does a DNS lookups and displays the answers that are returned from the queried name servers.
The main difference is that dig checks name resolution, while traceroute checks the network path. 
A domain can resolve correctly in DNS but still fail because of routing, firewall, or network path issues.

\#### What are the 3 or 4 most common DNS records and what are their use cases?
The most common DNS records are A, CNAME, MX, and TXT records.

An A record maps a domain name to an IPv4 address. In cloud infrastructure, this is commonly used to point a domain to a public load balancer IP address.

A CNAME record points one DNS name to another DNS name. For example, www.example.com could point to example.com or to another cloud service hostname.

An MX record is used for email. It tells other mail servers where email for a domain should be delivered.

A TXT record stores text values for a domain. TXT records are often used for domain verification, SPF, DKIM, and other security or ownership checks. Google Cloud’s DNS setup documentation shows common records such as A and CNAME records when configuring a domain in Cloud DNS.


\#### Give an overview of the steps in a TLS handshake.



\#### How does an SSL/TLS cert know what domain it belongs to?



\#### What is a certificate authority?
certificate authority, or CA, is a trusted organization that issues SSL/TLS certificates. The CA verifies that the person or organization requesting the certificate has control over the domain. After verification, the CA signs the certificate.


- **Load Balancers**

\#### How do application load balancers in GCP offload SSL? What part of the load balancer does this?
In Google Cloud, an external Application Load Balancer can terminate HTTPS traffic at the frontend. This means the user connects to the load balancer using HTTPS, and the load balancer handles the SSL/TLS certificate and decryption process before forwarding traffic toward the backend.

The main load balancer component involved is the target HTTPS proxy. The forwarding rule sends TCP port 443 traffic to the target HTTPS proxy. The target HTTPS proxy uses the SSL certificate and URL map to handle the HTTPS request and route it to the correct backend. Google’s documentation says that target HTTPS proxies use SSL certificates for HTTPS load balancing, and Google-managed certificates must be referenced by a target HTTPS proxy or target SSL proxy.

This is called SSL offload because the backend VMs do not each need to manage the public SSL certificate for the original client connection. Instead, the load balancer handles the client-facing HTTPS connection.

\#### Are there use cases to have in-flight encryption from the backend service to the backend itself?
Yes. Some environments need encryption not only from the client to the load balancer, but also from the load balancer to the backend. This is common in environments with strict security, compliance, or data protection requirements.


- **Cloud Domain/DNS**

\#### Can multiple domains end up pointing to the same load balancer?
Yes. Multiple domains can point to the same load balancer.
For example: jshaw7.com, www.jshaw7.com, and app.jshaw7.com can all resolve to the same load balancer IP address.

\#### In the context of Cloud DNS, what are zones?
In Cloud DNS, a zone is a container for DNS records that belong to a specific DNS namespace, such as jshaw7.com. A managed zone holds records for the same DNS name suffix, and a project can have multiple managed zones as long as each zone has a unique name

Cloud DNS supports public and private zones. A public zone is visible from the internet, while a private zone is only visible from selected VPC networks.

\## Terraform Notes

### Commands Ran
## Terraform Notes

### Commands Ran

```bash
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
terraform output
terraform output
load_balancer_ip = "8.232.112.147"
colombia_url = "http://8.232.112.147/colombia"
thailand_url = "http://8.232.112.147/thailand"

Validation Results
terraform fmt completed successfully.
terraform validate completed successfully.
The first terraform plan found an issue where google_compute_network.vpc and google_compute_subnetwork.web were referenced before being declared.
After adding the missing VPC and subnet resources, terraform plan completed successfully.
terraform apply -auto-approve completed successfully.
Terraform created the VPC, firewall rules, instance templates, managed instance groups, health check, HTTP load balancer, HTTPS frontend, Google-managed SSL certificate, and DNS record.


\## Testing Notes

HTTP Test

http://8.232.112.147/colombia
http://8.232.112.147/thailand
** Results: Both pages loaded successfully.**

DNS / HTTPS Test
http://jshaw7.com
https://jshaw7.com

```text
HTTP and HTTPS loaded successfully.
** Results: Domain pointed to the load balancer. HTTPS was configured using a Google-managed SSL certificate **