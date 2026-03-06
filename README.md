# 🏗️ Terraform Templates

Ready-to-use Terraform templates for provisioning AWS infrastructure. Just plug in your values and run `terraform apply`.

> No more writing Terraform from scratch. Copy a template, edit the variables, and deploy.

---

## 🚀 How to Use (Step by Step for Beginners)

### Step 1: Install Terraform

If you haven't installed Terraform yet, follow [this guide](https://github.com/ajayautade/devops-installation-guide/blob/main/guides/terraform.md).

### Step 2: Configure AWS Credentials

```bash
# Install AWS CLI (if not installed)
sudo apt install -y awscli

# Configure your AWS access keys
aws configure
# It will ask for:
# - AWS Access Key ID (from AWS Console → IAM → Users → Security credentials)
# - AWS Secret Access Key
# - Default region (e.g., ap-south-1 for Mumbai)
# - Output format (just press Enter for default)
```

### Step 3: Pick a Template

```bash
# Clone this repo
git clone https://github.com/ajayautade/terraform-templates.git
cd terraform-templates

# Go to the template you need
cd ec2-instance    # or vpc, s3-bucket, rds, eks
```

### Step 4: Edit Variables

```bash
# Open the variables file and change values to match your needs
nano terraform.tfvars
```

### Step 5: Deploy!

```bash
terraform init       # Download required providers (run once)
terraform plan       # Preview what will be created
terraform apply      # Create the resources (type 'yes' to confirm)
```

### Step 6: Destroy When Done (saves money!)

```bash
terraform destroy    # Delete everything (type 'yes' to confirm)
```

---

## 📋 Available Templates

| Template | What it creates | Folder |
|----------|----------------|--------|
| EC2 Instance | A single EC2 server with security group | `ec2-instance/` |
| Security Group | Firewall with all DevOps ports pre-configured | `security-group/` |
| VPC | Full VPC with public/private subnets | `vpc/` |
| S3 Bucket | S3 bucket with versioning and encryption | `s3-bucket/` |
| RDS Database | MySQL/PostgreSQL managed database | `rds/` |
| EKS Cluster | Managed Kubernetes cluster on AWS | `eks/` |

---

## 💡 Tips for Beginners

- **Always run `terraform plan` before `terraform apply`** — it shows you what will be created
- **Always run `terraform destroy` when done** — AWS charges by the hour!
- **Never commit `.tfstate` files to Git** — they contain sensitive info
- **Use `terraform.tfvars`** to set your values — keeps your code clean
- To see what you've created: `terraform show`
- To list resources: `terraform state list`

---

## 📄 License

Open source — for personal use and learning.
