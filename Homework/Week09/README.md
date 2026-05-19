# Week 9 - Global Load Balancing, Cloud Armor, Cloud CDN, and Terraform

## Documentation and Resources Used

These are the resources I used for this week and how I used each one:

- [Cloud Load Balancing overview](https://cloud.google.com/load-balancing/docs/load-balancing-overview) - I used to understand how Google Cloud load balancers distribute traffic and how global external Application Load Balancers use a single frontend IP for user traffic.
- [External Application Load Balancer overview](https://cloud.google.com/load-balancing/docs/https) - I used to understand the main pieces of the load balancer: frontend IP, forwarding rule, target HTTP proxy, URL map, backend service, health check, and instance group backend.
- [Forwarding rules overview](https://cloud.google.com/load-balancing/docs/forwarding-rule-concepts) - I used to understand how the load balancer listens on an IP address, protocol, and port.
- [Cloud NAT overview](https://cloud.google.com/nat/docs/overview) - I used in the Terraform design so backend VMs can download packages without having public IP addresses.
- [Private NAT documentation](https://cloud.google.com/nat/docs/private-nat) - I used to compare Private NAT with regular Public NAT and understand that Private NAT is for private-to-private NAT scenarios.
- [Cloud Armor documentation](https://cloud.google.com/armor/docs) - I used to explain what Cloud Armor protects against and why it is placed at the edge of Google Cloud.
- [Cloud Armor security policy overview](https://cloud.google.com/armor/docs/security-policy-overview) - I used to explain allow, deny, redirect, rate-limit, and Layer 3 through Layer 7 matching rules.
- [Cloud Armor rate limiting overview](https://cloud.google.com/armor/docs/rate-limiting-overview) - I used to explain rate-based rules and how they protect applications from abusive request volume.
- [Cloud Armor bot management overview](https://cloud.google.com/armor/docs/bot-management) - I used this to understand how reCAPTCHA works with Cloud Armor bot management. It helped me explain how Cloud Armor can challenge suspicious traffic and help separate real users from bots.
- [Cloud CDN overview](https://cloud.google.com/cdn/docs/overview) - I used to explain cache locations, origins, and how Cloud CDN reduces latency and origin load.
- [Cloud CDN caching overview](https://cloud.google.com/cdn/docs/caching) - I used to explain cache modes and TTL behavior.
- [Cloud CDN TTL overrides](https://cloud.google.com/cdn/docs/using-ttl-overrides) - I used to explain how TTL controls content freshness.

---

## Q&A

### Load Balancers

#### How does load balancing contribute to fault tolerance? What about high availability?

Load balancing contributes to fault tolerance by spreading traffic across more than one backend server or instance. If one backend fails, the load balancer can stop sending traffic to that unhealthy backend and continue sending traffic to healthy backends.

Load balancing also supports high availability because the application is not tied to one single server. Multiple backend instances can serve the same application, so users can still reach the service during maintenance, patching, or a single instance failure.

#### Do global load balancers decrease latency for end users? Why or why not?

Yes, global load balancers can decrease latency when the application has healthy backends in locations closer to the user. A user in one part of the world can be routed through a nearby Google edge location and then sent to the best available backend.

This does not automatically make every application faster. If all backends are only in one region, the user still has to reach that region eventually. The global load balancer helps with edge entry and smart routing, but the backend location and application design still matter.

#### What are load balancer health checks for? Do we always need them? Is a load balancer different from a reverse proxy?

Health checks are used to test whether backend instances are ready to receive traffic. For example, a health check might send HTTP requests to port 80 and expect a successful response. If an instance fails the health check, the load balancer marks it unhealthy and stops sending user traffic to it.

For production load balancing, health checks are normally required because the load balancer needs a reliable way to know which backends are healthy. Some simple proxy setups might not use full health checks, but for Google Cloud backend services and managed instance groups, health checks are a standard part of the design.

A load balancer and a reverse proxy are related but not always the same thing. A reverse proxy sits in front of servers and forwards client requests to backend servers. A load balancer does that too, but it also focuses on distributing traffic across multiple backends, checking backend health, and improving availability.

#### What are load balancer routing rules and URL maps for? Give examples.

Routing rules and URL maps tell the load balancer where to send a request based on the hostname or path in the URL. Instead of sending every request to the same backend, the load balancer can make routing decisions.

Examples:

- Requests to `/colombia` can route to a backend service connected to a Colombia managed instance group.
- Requests to `/thailand` can route to a different backend service connected to a thailand managed instance group.
- Requests to `api.example.com` can route to an API backend, while `www.example.com` routes to a web frontend backend.

#### Explain what an anycast IP address is used for in the context of a global load balancer.

An anycast IP address lets the same IP address be advertised from multiple Google edge locations. Users connect to one public IP address, but their traffic enters Google's network at a nearby edge location.

For a global external load balancer, this is useful because users around the world can use the same frontend IP while Google routes the traffic through its global network to an appropriate backend.

---

### Cloud Armor

#### What does Cloud Armor offer?

Cloud Armor offers security policies for applications behind supported Google Cloud load balancers. It can allow, deny, rate-limit, or redirect traffic based on rules. It also includes web application firewall capabilities, preconfigured WAF rules, DDoS protections, geo/IP-based filtering, and bot management features.

#### Why is it used in the first place?

Cloud Armor is used to protect public-facing applications before unwanted traffic reaches the backend servers. Instead of letting every request reach the VPC and the virtual machines, Cloud Armor can filter bad or suspicious traffic closer to Google's edge.

This helps reduce application risk, backend load, and exposure to common attacks such as volumetric attacks, abusive request floods, and application-layer attacks.

#### What layer in the OSI model does it operate at? Why is this important and how is this firewall different from VPC firewall rules?

Cloud Armor can match traffic using Layer 3 through Layer 7 attributes, depending on the policy and load balancer type. For web applications, the important part is Layer 7 because Cloud Armor can inspect HTTP request details such as URL path, headers, request method, and WAF signatures.

This is different from VPC firewall rules. VPC firewall rules mainly control network access to VM network interfaces using things like source IP ranges, protocols, ports, service accounts, and network tags. Cloud Armor protects at the load balancer edge and can make application-aware decisions. VPC firewall rules protect access inside the VPC network.

#### What are rate-based rules for?

Rate-based rules are used to control how many requests a client can send within a certain time window. They help protect applications from request floods, abusive clients, bots, login abuse, scraping, or traffic spikes that could exhaust backend resources.

For example, a rule could throttle or deny a client that sends too many requests to `/login` in a short period of time.

#### What is reCAPTCHA and how does it relate to this service?

reCAPTCHA is a service that helps determine whether a request is likely coming from a real human or from an automated bot. With Cloud Armor bot management, reCAPTCHA tokens or challenges can be used in security policy decisions.

For example, Cloud Armor can redirect suspicious traffic to a reCAPTCHA challenge or use reCAPTCHA token information as part of the allow or deny decision.

---

### Cloud CDN

#### What are POPs used for?

POPs, or points of presence, are edge locations where cached content can be stored closer to users. When a user requests cacheable content, Cloud CDN can serve it from a nearby cache instead of going all the way back to the origin every time.

#### What kind of files are served with Cloud CDN?

Cloud CDN is commonly used for static or cacheable content such as images, CSS, JavaScript, fonts, videos, downloads, and other web assets. It can also cache certain HTTP responses when the origin and cache policy allow it.

It should not be used to cache private, user-specific, or frequently changing content unless the cache settings are carefully designed.

#### What services can be used with Cloud CDN for the source of content, the origin?

Cloud CDN can use supported load balancer backends as origins. Common origins include backend services connected to managed instance groups, unmanaged instance groups, network endpoint groups, serverless NEGs, internet NEGs, and backend buckets using Cloud Storage.

#### Does Cloud CDN help protect against any types of malicious actors or cyberattacks? Explain.

Cloud CDN can help reduce the impact of some traffic spikes because cacheable content can be served from edge caches instead of always hitting the origin. This can lower origin load during high traffic.

However, Cloud CDN is not a full security product by itself. It should be paired with Cloud Armor for stronger web application protection, DDoS policy enforcement, rate limiting, and WAF controls.

#### Should an enterprise always use Cloud CDN? Why or why not?

No, an enterprise should not always use Cloud CDN automatically. Cloud CDN is a good fit when the application serves public, cacheable content and users are spread across different locations.

It may not be a good fit for applications with highly dynamic, private, or user-specific content because caching the wrong data can create security and freshness problems. Enterprises should use it when it improves performance, reduces origin load, and fits the application's cache requirements.

#### What is TTL and how does it control content freshness?

TTL means Time To Live. It controls how long content can stay in cache before Cloud CDN needs to revalidate it or fetch a newer version from the origin.

A longer TTL can improve performance because content stays cached longer, but users might see older content after changes. A shorter TTL keeps content fresher, but it can increase requests back to the origin.

---

## Runbook - Configure a Global External Application Load Balancer with a MIG Backend Using ClickOps

### End Goal

Create a global external Application Load Balancer that serves HTTP traffic on port 80. The backend will be a managed instance group running a basic web server. Health checks are required so the load balancer only sends traffic to healthy instances.

### Prerequisites

- Google Cloud project selected and billing enabled.
- Required APIs enabled: Compute Engine API.
- IAM permissions to create VPC networks, firewall rules, instance templates, managed instance groups, health checks, backend services, URL maps, forwarding rules, and global IP addresses.
- A custom VPC and subnet, or permission to create them.
- A VM image or startup script that installs and starts a web server on port 80.
- Firewall rule allowing Google load balancer health check ranges to reach backend instances on TCP port 80.
- Decide the backend region and zone before creating the MIG.

### High-Level Build Steps

#### 1. Create or confirm the network

1. Go to **VPC network > VPC networks**.
2. Create a custom VPC if one does not already exist.
3. Create a subnet in the region where the managed instance group will run.
4. Keep the CIDR small for a lab, for example `/24`, unless class standards require a different range.

Key setting: use a custom VPC instead of the default VPC so the environment is controlled and easier to explain.

#### 2. Create the firewall rule for health checks

1. Go to **VPC network > Firewall**.
2. Create an ingress firewall rule.
3. Set the network to the custom VPC.
4. Set source ranges to:
   - `130.211.0.0/22`
   - `35.191.0.0/16`
5. Allow TCP port `80`.
6. Use a target tag such as `allow-lb-health-check`.

Key setting: the target tag must also be placed on the backend VM template. Without this rule, the health check can fail and the load balancer will not send traffic to the MIG.

#### 3. Create the instance template

1. Go to **Compute Engine > Instance templates**.
2. Create a new instance template.
3. Use a small machine type such as `e2-micro` for lab cost control.
4. Use a Debian image unless class used a different image.
5. Add the network tag `allow-lb-health-check`.
6. Place the VM on the custom VPC/subnet.
7. Add a startup script that installs and starts Nginx or Apache on port 80.

Key setting: the web server must listen on port 80 because the health check and backend service will use that port.

#### 4. Create the managed instance group

1. Go to **Compute Engine > Instance groups**.
2. Create a managed instance group from the instance template.
3. Choose the same region or zone planned for the lab.
4. Set the target size based on class requirements, usually `1` or `2` for a lab.
5. Configure named port:
   - Name: `http`
   - Port: `80`

Key setting: the backend service uses the named port, so the named port must match the backend service configuration.

#### 5. Create the health check

1. Go to **Network services > Load balancing > Health checks**.
2. Create an HTTP health check.
3. Protocol: HTTP.
4. Port: 80.
5. Request path: `/`.
6. Use normal lab values unless class required different timing.

Key setting: a simple `/` health check works if the web server returns a successful page from the root path.

#### 6. Create the global external Application Load Balancer

1. Go to **Network services > Load balancing**.
2. Click **Create load balancer**.
3. Choose **Application Load Balancer**.
4. Choose **Internet facing**.
5. Choose **Global external Application Load Balancer**.
6. Choose HTTP for the frontend if this is a lab without SSL.

#### 7. Configure the backend service

1. Create a backend service.
2. Select the managed instance group as the backend.
3. Set the named port to `http`.
4. Attach the HTTP health check created earlier.
5. Keep Cloud CDN disabled unless the lab requires CDN testing.

Key setting: Cloud CDN is useful for static content, but for basic troubleshooting it may be easier to leave it off at first so page changes are visible immediately.

#### 8. Configure routing

1. In the load balancer routing section, use the default URL map for a single backend.
2. For multiple backend services, add path rules.
3. Example path rules:
   - `/colombia` and `/colombia/*` -> Colombia backend service
   - `/thailand` and `/thailand/*` -> thailand backend service

Key setting: path rules allow one frontend IP to route traffic to different backend services.

#### 9. Configure the frontend

1. Create a frontend listener.
2. Protocol: HTTP.
3. IP version: IPv4.
4. IP address: create or select a global static IP.
5. Port: `80`.

Key setting: the forwarding rule listens on the public IP and forwards matching traffic to the target HTTP proxy and URL map.

#### 10. Test the load balancer

1. Wait until the backend shows healthy.
2. Open `http://<LOAD_BALANCER_IP>/` in a browser.
3. If using path rules, test:
   - `http://<LOAD_BALANCER_IP>/colombia`
   - `http://<LOAD_BALANCER_IP>/thailand`
4. If the backend is unhealthy, check:
   - VM web server status.
   - Firewall rule source ranges and target tags.
   - MIG named port.
   - Health check path and port.
   - Startup script completion.

### Test Validation

Tester name: `____________________`

Date tested: `____________________`

Result: `Pass / Fail`

Notes or fixes found during testing: `____________________`

---

## Terraform Notes

The Terraform code for this week is stored in the `terraform` subdirectory.

This lab creates:

- Custom VPC and subnet.
- Cloud Router and Cloud NAT so backend VMs do not need public IP addresses.
- Firewall rules using target tags.
- Two managed instance groups:
  - `colombia`
  - `thailand`
- Two backend services.
- One global external Application Load Balancer.
- URL path routing:
  - `/colombia` routes to the Colombia backend.
  - `/thailand` routes to the thailand backend.
- Informative outputs for testing.

Cloud CDN is controlled by the Terraform variable `enable_cdn`. It is set to `false` by default so page changes are easier to see during testing. Set it to `true` only when testing CDN behavior for cacheable static content.

### Terraform Commands

Run these commands from inside the `terraform` directory:

```bash
terraform init
terraform fmt 
terraform validate
terrafrom plan
terraform apply -auto-approve
```

After testing, destroy the lab to avoid unnecessary charges:

```bash
terraform destroy
```

### Important Git Notes

Do not commit Terraform state, lock files, crash logs, plan files, provider binaries, or the `.terraform` directory. The `terraform/.gitignore` file blocks those files.
