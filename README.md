# Azure Nomad Cluster Deployment

Deploy a secure, scalable HashiCorp Nomad cluster on Microsoft Azure using Terraform. Features robust security, network isolation, and automated provisioning.

[![Azure](https://img.shields.io/badge/Azure-Cloud%2520Platform-0078D4?logo=microsoft-azure)](https://azure.microsoft.com)
[![Terraform](https://img.shields.io/badge/Terraform-Infrastructure%2520as%2520Code-7B42BC?logo=terraform)](https://terraform.io)
[![Nomad](https://img.shields.io/badge/Nomad-Orchestration-00CA8E?logo=hashicorp)](https://www.nomadproject.io)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

## Contents

1. [Architecture Overview](#architecture-overview)
2. [Prerequisites](#prerequisites)
3. [Quick Start](#quick-start)
4. [Configuration](#configuration)
5. [Accessing the Cluster](#accessing-the-cluster)
6. [Sample Application](#sample-application)
7. [Maintenance](#maintenance)
8. [Troubleshooting](#troubleshooting)

## Architecture Overview

### Component Structure

```plaintext
Azure Subscription
├── Virtual Network (VNet)
├── Network Security Groups (NSGs)
│   ├── Inbound rules (SSH, HTTP, Nomad ports)
│   └── CIDR-based restrictions
├── Nomad Server Nodes (3–5 instances)
│   ├── Consul for service discovery
│   └── Token-based ACL system
├── Nomad Client Nodes (1–10 instances)
│   ├── Docker runtime
│   └── Workload execution
└── Load Balancer
    ├── Nomad UI access
    └── Application routing
```

### Key Features

- Azure-optimized infrastructure
- Flexible scaling options
- Enhanced security:
  - NSG-based network isolation
  - Token-based access control
  - SSH key authentication
  - IP allowlisting
- Terraform-driven deployment

## Prerequisites

### Required Tools

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://www.terraform.io/downloads) (≥1.0)
- [JQ](https://stedolan.github.io/jq/download/)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Generate SSH Keys

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## Quick Start

1. **Clone Repository**
```bash
git clone https://github.com/LAVI9966/DecodeTasK.git
cd DecodeTasK
```

2. **Azure Authentication**
```bash
az login
```

3. **Configure Variables**
```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`:
```hcl
subscription_id = "your-azure-subscription-id"
client_id       = "your-azure-client-id"
client_secret   = "your-azure-client-secret"
tenant_id       = "your-azure-tenant-id"
ssh_key_path    = "~/.ssh/id_rsa.pub"
server_count    = 3
client_count    = 5
region          = "UKSouth"
```

4. **Deploy Infrastructure**
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

5. **Deploy Demo App**
```bash
./scripts/deploy_hello_world.sh
```

## Configuration

### Variables Reference

| Variable | Description | Default |
|----------|-------------|---------|
| subscription_id | Azure subscription ID | - |
| client_id | Azure SP client ID | - |
| client_secret | Azure SP secret | - |
| tenant_id | Azure tenant ID | - |
| ssh_key_path | SSH public key location | ~/.ssh/id_rsa.pub |
| server_count | Nomad servers | 3 |
| client_count | Nomad clients | 5 |
| region | Azure region | UKSouth |
| vm_size | VM instance size | Standard_B2s |
| admin_username | VM admin user | nomadadmin |

### Network Settings
- Separate subnets for server/client nodes
- Restricted NSG port access
- Admin CIDR restrictions

## Cluster Access

Get connection details:
```bash
terraform output nomad_ui_url
terraform output nomad_bootstrap_token
terraform output hello_world_app_url
terraform output ssh_connection_server
```

## Sample Application

The hello-world deployment demonstrates:
- Consul service discovery
- Load balancing
- Health monitoring
- Horizontal scaling

## Maintenance

### Scale Cluster
Update counts in `terraform.tfvars`:
```bash
terraform apply -auto-approve
```

### Update Config
```bash
terraform plan
terraform apply
```

### Cleanup
```bash
terraform destroy
```

## Troubleshooting

### Auth Issues
- Check Azure login: `az account show`
- Verify SP permissions

### SSH Problems
- Validate SSH key path
- Review NSG rules

### Cluster Issues
- Check logs:
```bash
journalctl -u nomad -f
journalctl -u consul -f
nomad node status -self
```

### App Deployment
- Check job: `nomad job status hello-world`
- View logs: `nomad alloc logs`



