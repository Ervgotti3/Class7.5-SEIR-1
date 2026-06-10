# Week 13 Homework - VPN, FinOps, and Billing Controls

## Overview

This repository contains the Week 13 homework deliverables assigned Friday 6/5/26 and due Thursday 6/11/26. The work covers Google Cloud Classic VPN, HA VPN comparison, cross-account runbook creation, FinOps alerting with SMS notifications, and automatic billing-disable workflows.

## Deliverables Completed

- Individual work:
  - Detailed explanation of the difference between Classic VPN and HA VPN.
- Group work:
  - Runbook for GCP Classic VPN in route-based mode for 2 partners across accounts.
  - Peer testing by at least one additional pair.
- FinOps:
  - SMS budget notification setup using Google Cloud native services only.
  - Runbook for deployment.
  - Documentation for each service used.
  - Basic architecture diagram.
  - Discussion of how the solution supports FinOps practices.
- Billing control:
  - Implementation of disabling billing usage with notifications.
  - Explanation of services involved.
  - Screenshots.
  - Discussion of why this approach may be unwise in production.

## Repository Contents

- `README.md` - Weekly summary and documentation index.
- `individual/` - Individual assignment write-up for Classic VPN vs HA VPN.
- `runbook/` - Group runbook for Classic VPN route-based setup.
- `finops/` - FinOps runbook, service documentation, and architecture diagram.
- `billing-control/` - Billing disablement implementation notes and screenshots.

## Individual Work

### Classic VPN vs HA VPN

Classic VPN is Google Cloud’s older VPN offering and supports static routing. It can be configured as either policy-based or route-based. In route-based mode, the tunnel uses local and remote traffic selectors of `0.0.0.0/0`, and specific remote CIDR ranges are reached through custom static routes.

HA VPN is the newer high-availability design intended for stronger resilience and better production readiness. Compared with Classic VPN, HA VPN is better suited for fault tolerance, redundancy, and more modern cloud networking patterns.

### Key Difference Summary

| Feature | Classic VPN | HA VPN |
|---------|-------------|--------|
| Routing support | Static routing, policy-based or route-based | Designed for highly available cloud VPN connectivity |
| Route-based behavior | Uses `0.0.0.0/0` traffic selectors with static routes for remote ranges | Built for resilient multi-tunnel architecture |
| Availability model | More basic | Higher availability and stronger redundancy |
| Best fit | Labs, simpler environments, legacy compatibility | Production-style resilient deployments |

### Analogy

A Classic VPN is like a single bridge between two islands. It works, but if that bridge has a problem, traffic is interrupted. HA VPN is more like a pair of engineered highway bridges with better failover paths, so traffic has a better chance of continuing even when one path is unavailable.

## Group Runbook

### GCP Classic VPN in Route-Based Mode

The group runbook documents how two partners in separate Google Cloud accounts create a Classic VPN connection in route-based mode.

### High-Level Steps

1. Create or identify a VPC network and subnet in each partner account.
2. Reserve a regional external IP address for each VPN gateway.
3. Create the Classic VPN gateway in each project.
4. Create the tunnel on each side using the other partner’s public peer IP.
5. Use route-based configuration.
6. Configure pre-shared keys and matching IKE settings.
7. Create static routes for remote CIDR ranges using the VPN tunnel as the next hop.
8. Configure firewall rules to allow required traffic.
9. Validate tunnel status and test connectivity between both environments.

### Important Technical Notes

For route-based Classic VPN, Google Cloud sets both local and remote traffic selectors to `0.0.0.0/0`. The remote network IP ranges are then used to create custom static routes that point to the VPN tunnel.

## FinOps

### Goal

The FinOps section focuses on controlling cloud cost visibility and response using native Google Cloud services without third-party tools or custom external systems.

### Services Used

- Cloud Billing Budgets for spend thresholds.
- Pub/Sub for programmatic budget notifications.
- Cloud Monitoring notification channels for SMS alert delivery.
- Budget alerts and notification logic for cost awareness and operational response.

### FinOps Value

This solution supports FinOps by improving visibility, accountability, and timely response to cloud spending. SMS alerts help teams react quickly to rising costs, while budget thresholds support governance and shared responsibility around cloud usage.

## Disable Billing with Notifications

### What Was Implemented

A billing-control workflow was implemented based on Google Cloud’s documented pattern. The workflow uses a budget alert, Pub/Sub notification, and a function-based action to remove the project’s billing account once spend exceeds the defined threshold.

### Services Involved

- Cloud Billing Budget
- Pub/Sub
- Cloud Run function / function-based automation
- IAM
- Cloud Billing API

### Why This Is Risky in Production

This approach can be unwise in production because disabling billing shuts down services in the project, including Free Tier services. Google also warns that billing alerts are not instantaneous, so charges may still continue for some usage before the disable action occurs. In a real production environment, this could cause outages, failed transactions, and service disruption for users.

## Screenshots

Add screenshots for the following:

- Classic VPN gateway configuration
- VPN tunnel status
- Static routes
- Budget alert configuration
- Notification channel configuration
- Pub/Sub topic
- Billing-disable function deployment
- Billing account/project linkage before and after testing

## Resources Used

### Google Cloud Classic VPN Documentation
Used to understand how route-based Classic VPN works, especially the `0.0.0.0/0` traffic selectors and the creation of static routes for remote ranges.

### Google Cloud Billing Disablement Documentation
Used to understand the architecture for using budget notifications and a function-triggered action to disable billing on a project after the budget threshold is exceeded.

### Cloud Billing Programmatic Notifications
Used to understand how Pub/Sub-based budget notifications support automated workflows tied to billing thresholds.

## Notes

All work in this repository follows the standard homework repository submission process. Documentation is included to show what resources were used, how they were used, and how each deliverable was completed.