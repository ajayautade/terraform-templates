# EC2 Instance Template

## What This Creates
- 1 EC2 instance (virtual server)
- 1 Security Group (firewall rules — SSH, HTTP, HTTPS, custom port)

## Step-by-Step Guide

### 1. Go to this folder
```bash
cd ec2-instance
```

### 2. Edit your values
Open `terraform.tfvars` and change:
```hcl
aws_region    = "ap-south-1"              # Your AWS region
project_name  = "my-server"               # Name for your server
instance_type = "t2.micro"                # t2.micro = free tier
key_pair_name = "your-key-pair-name"      # ⚠️ Your AWS key pair name
volume_size   = 20                        # Disk space in GB
my_ip         = "YOUR_IP/32"             # Your IP (find at whatismyip.com)
custom_port   = 8080                      # Extra port (Jenkins=8080, Grafana=3000)
```

> **How to find your Key Pair name:** AWS Console → EC2 → Key Pairs

> **How to find your IP:** Go to https://whatismyip.com and add `/32` at the end

### 3. Initialize Terraform
```bash
# Downloads the AWS provider plugin (run only once)
terraform init
```

### 4. Preview what will be created
```bash
# Shows you exactly what Terraform will create — no changes made yet
terraform plan
```

### 5. Create the instance
```bash
# Actually creates the EC2 instance — type 'yes' to confirm
terraform apply
```

### 6. Get your server details
```bash
# After apply, Terraform shows the public IP and SSH command
terraform output
```

### 7. SSH into your new server
```bash
ssh -i "your-key.pem" ubuntu@<PUBLIC_IP_FROM_OUTPUT>
```

### 8. Destroy when done (saves money!)
```bash
terraform destroy
```

## Files in this folder

| File | Purpose |
|------|---------|
| `main.tf` | The actual infrastructure code (EC2 + Security Group) |
| `variables.tf` | Defines all configurable options |
| `terraform.tfvars` | **Your values go here** — edit this file |
| `outputs.tf` | What info to show after creation (IP, SSH command) |

## Common Errors

| Error | Fix |
|-------|-----|
| `InvalidKeyPair.NotFound` | Your `key_pair_name` is wrong — check AWS Console → EC2 → Key Pairs |
| `UnauthorizedAccess` | Run `aws configure` and set your AWS keys |
| `InvalidAMIID` | The AMI ID doesn't exist in your region — search for Ubuntu AMI in your region |
