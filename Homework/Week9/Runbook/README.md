\# Runbook



\## End Goal



The goal of this runbook is to create a fully configured Google Cloud external Application Load Balancer using ClickOps. The load balancer will use a managed instance group as the backend and will require an HTTP health check. After completion, users should be able to reach the application through the load balancer frontend IP address on port 80.



\## Prerequisites



Before starting, the engineer should have the following ready:



\- Access to the correct Google Cloud project

\- Compute Engine API enabled

\- Permission to create Compute Engine, VPC firewall, health check, and load balancing resources

\- A VPC and subnet available for the backend VM instances

\- A basic startup script or web server configuration that serves HTTP traffic on port 80

\- A target network tag for the backend instances, such as `allow-http`

\- A planned region and zone for the managed instance group

\- A naming standard for the resources



\## Key Settings



| Setting | Value Used | Reason |

|---|---|---|

| Load balancer type | External Application Load Balancer | Required for HTTP traffic from the internet |

| Frontend protocol | HTTP | Matches the class requirement and avoids needing an SSL certificate |

| Frontend port | 80 | Required for standard HTTP access |

| Backend type | Managed instance group | Required by the assignment |

| Backend protocol | HTTP | The backend web servers listen on port 80 |

| Health check | HTTP health check | Required to verify backend instance health |

| Named port | `http:80` | Allows the backend service to send traffic to port 80 on the MIG |

| Firewall target | Target tag | Required so only tagged backend instances receive allowed traffic |

| CDN | Disabled unless required | Kept off for basic testing so content changes are easier to verify |



\## Procedure



\### 1. Create the Instance Template



1\. Go to \*\*Compute Engine > Instance templates\*\*.

2\. Select \*\*Create instance template\*\*.

3\. Enter a name such as `week9-web-template`.

4\. Select the machine type used in class.

5\. Under \*\*Boot disk\*\*, select the same operating system image used in class.

6\. Under \*\*Networking\*\*, select the correct VPC and subnet.

7\. Add the backend network tag, such as:



&#x20;  ```text

&#x20;  allow-http

8\. Under Advanced options > Management > Automation, add the startup script that installs and starts the web server.

9\. Confirm the startup script serves content on port 80.

10\. Select Create.



\### 2. Create the Managed Instance Group



1. Go to Compute Engine > Instance groups.

2\. Select Create instance group.

3\. Choose New managed instance group (stateless).

4\. Enter a name such as week9-web-mig.

5\. Select the instance template created earlier.

6\. Choose the region and zone used for the assignment.

7\. Set the group size based on class requirements.

8\. Leave autoscaling settings the same as class unless your group leader says otherwise.

9\. Create the MIG.

10.After creation, open the MIG and confirm the instances are running.



\### 3. Configure the MIG Named Port



1. Open the managed instance group.

2\. Select Edit.

3\. Find the Port mapping or Named ports section.

4\. Add the following named port:

&#x20;  Name: http

&#x20;  Port: 80

5\. Save the change.



\### 4. Create the Firewall Rule

1. Go to VPC network > Firewall.

2\. Select Create firewall rule.

3\. Use a name such as:

&#x20;  allow-http-health-check

4\. Select the correct VPC network.

5\. Set Direction of traffic to Ingress.

6\. Set Action on match to Allow.

7\. Under Targets, choose Specified target tags.

8\. Add the backend tag used on the instance template:

&#x20;  allow-http

9\. For source IPv4 ranges, add the required Google health check/load balancer ranges:

&#x20;  130.211.0.0/22

&#x20;  35.191.0.0/16

10.Under protocols and ports, allow:

&#x20;  tcp:80

11.Create the firewall rule.



\### 5. Create the Health Check

1. Go to Network Services > Load balancing > Health checks.

2\. Select Create health check.

3\. Enter a name such as: week9-http-health-check

4\. Set protocol to HTTP.

5\. Set port to 80.

6\. Use the request path used in class. If no custom path is required, use: /

7\. Leave the check interval, timeout, healthy threshold, and unhealthy threshold at the class/default values unless told otherwise.

8\. Create the health check.



\### 6. Create the External Application Load Balancer

1. Go to Network Services > Load balancing.

2\. Select Create load balancer.

3\. Choose Application Load Balancer.

4\. Select Internet-facing / External.

5\. Select Global.

6\. Select HTTP as the protocol.

7\. Start the load balancer configuration.



\### 7. Configure the Backend Service

1. In the load balancer setup, go to Backend configuration.

2\. Select Create a backend service.

3\. Enter a backend service name such as:week9-web-backend



