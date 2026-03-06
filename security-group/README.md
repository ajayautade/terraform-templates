# Security Group Template

## What This Creates
A Security Group (firewall) with all common DevOps ports pre-configured:

| Port | Tool | Access |
|------|------|--------|
| 22 | SSH | Your IP only |
| 80 | HTTP / Nginx | Public |
| 443 | HTTPS | Public |
| 3000 | Grafana | Public |
| 8080 | Jenkins / ArgoCD | Public |
| 9000 | SonarQube | Public |
| 9090 | Prometheus | Public |

## Step-by-Step Guide

### 1. Edit your values
```bash
cd security-group
```

Open `variables.tf` or create `terraform.tfvars`:
```hcl
aws_region   = "ap-south-1"
project_name = "my-devops-server"
my_ip        = "YOUR_IP/32"          # ⚠️ Go to whatismyip.com and add /32
```

### 2. Deploy
```bash
terraform init
terraform plan
terraform apply
```

### 3. Use the Security Group ID
```bash
terraform output security_group_id
# Copy this ID and use it when launching EC2 instances
```

### 4. Destroy when done
```bash
terraform destroy
```

## Files

| File | Purpose |
|------|---------|
| `main.tf` | All firewall rules (inbound + outbound) |
| `variables.tf` | Region, name, your IP |
| `outputs.tf` | Security group ID (use in other templates) |
