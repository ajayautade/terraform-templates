# RDS Database Template

## What This Creates
- 1 RDS Instance (managed MySQL or PostgreSQL database)
- 1 Security Group (controls who can connect to the database)

## Step-by-Step Guide

### 1. Go to this folder
```bash
cd rds
```

### 2. Edit your values
Open `terraform.tfvars`:
```hcl
aws_region        = "ap-south-1"
project_name      = "my-database"
db_engine         = "mysql"                    # or "postgres"
db_engine_version = "8.0"                      # MySQL 8.0 or PostgreSQL 15
db_instance_class = "db.t3.micro"              # Free tier eligible!
db_storage        = 20                         # GB
db_name           = "myapp"                    # Database name
db_username       = "admin"                    # Master username
db_password       = "YourStrongPassword123!"   # ⚠️ Use a strong password!
```

### 3. Deploy
```bash
terraform init
terraform plan
terraform apply
```

### 4. Connect to your database
```bash
# Get the endpoint
terraform output rds_endpoint

# Connect with MySQL CLI
mysql -h <ENDPOINT> -P 3306 -u admin -p myapp

# Or with PostgreSQL
psql -h <ENDPOINT> -p 5432 -U admin -d myapp
```

### 5. Destroy when done (saves money!)
```bash
terraform destroy
```

## ⚠️ Important Notes
- RDS is **NOT free tier** for all instance types — `db.t3.micro` is free tier eligible
- **Never commit your `terraform.tfvars` with real passwords to Git** — add it to `.gitignore`
- For production, set `publicly_accessible = false` and use a VPC

## Files

| File | Purpose |
|------|---------|
| `main.tf` | RDS instance + security group |
| `variables.tf` | All configurable options |
| `terraform.tfvars` | **Your values here** |
| `outputs.tf` | Endpoint and connection string |
