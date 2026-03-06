# VPC Template

## What This Creates
- 1 VPC (your private network in AWS)
- 2 Public Subnets (for web servers — can reach internet directly)
- 2 Private Subnets (for databases — hidden from internet)
- 1 Internet Gateway (connects public subnets to internet)
- 1 NAT Gateway (lets private subnets download packages without being exposed)
- Route Tables (traffic rules for each subnet)

## Why You Need a VPC
Think of a VPC as your own private data center inside AWS. Without it, all your resources are on a shared network. With a VPC you control:
- Who can access your servers
- Which servers can talk to each other
- Which servers can reach the internet

## Step-by-Step Guide

### 1. Go to this folder
```bash
cd vpc
```

### 2. Edit your values
Open `variables.tf` and change the defaults, or create a `terraform.tfvars`:
```hcl
aws_region            = "ap-south-1"
project_name          = "my-project"
vpc_cidr              = "10.0.0.0/16"       # 65,000+ IPs for your VPC
public_subnet_1_cidr  = "10.0.1.0/24"       # 256 IPs for public subnet 1
public_subnet_2_cidr  = "10.0.2.0/24"       # 256 IPs for public subnet 2
private_subnet_1_cidr = "10.0.3.0/24"       # 256 IPs for private subnet 1
private_subnet_2_cidr = "10.0.4.0/24"       # 256 IPs for private subnet 2
```

### 3. Deploy
```bash
terraform init          # Download providers (once)
terraform plan          # Preview changes
terraform apply         # Create VPC (type 'yes')
```

### 4. Use the VPC with other templates
After creating the VPC, you'll get output IDs. Use them in other templates:
```bash
terraform output        # Shows vpc_id, subnet IDs
```
Copy the subnet IDs into the EKS or RDS template's `terraform.tfvars`.

### 5. Destroy when done
```bash
terraform destroy
```

## How It Looks
```
┌─────────────────── VPC (10.0.0.0/16) ───────────────────┐
│                                                           │
│  ┌─── Public Subnet 1 ──┐  ┌─── Public Subnet 2 ──┐    │
│  │   10.0.1.0/24         │  │   10.0.2.0/24         │    │
│  │   Web servers, ALB    │  │   Web servers, ALB    │    │
│  └───────────────────────┘  └───────────────────────┘    │
│           │                          │                    │
│     Internet Gateway (connects to internet)               │
│                                                           │
│  ┌─── Private Subnet 1 ─┐  ┌─── Private Subnet 2 ─┐    │
│  │   10.0.3.0/24         │  │   10.0.4.0/24         │    │
│  │   Databases, APIs     │  │   Databases, APIs     │    │
│  └───────────────────────┘  └───────────────────────┘    │
│           │                                               │
│     NAT Gateway (private subnets download packages)       │
│                                                           │
└───────────────────────────────────────────────────────────┘
```

## Files

| File | Purpose |
|------|---------|
| `main.tf` | VPC, subnets, gateways, route tables |
| `variables.tf` | Configurable options (region, CIDR ranges) |
| `outputs.tf` | VPC ID and subnet IDs (needed by other templates) |
