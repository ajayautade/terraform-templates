# S3 Bucket Template

## What This Creates
- 1 S3 Bucket with:
  - ✅ Versioning (keeps old versions of files)
  - ✅ Encryption (data encrypted at rest)
  - ✅ Public access blocked (prevents accidental exposure)

## Step-by-Step Guide

### 1. Go to this folder
```bash
cd s3-bucket
```

### 2. Edit your values
Open `terraform.tfvars`:
```hcl
aws_region  = "ap-south-1"
bucket_name = "my-unique-bucket-ajay-2024"   # ⚠️ Must be globally unique!
```

> **Bucket names are global** — if someone else already has that name, pick a different one. Add your name + random numbers.

### 3. Deploy
```bash
terraform init
terraform plan
terraform apply
```

### 4. Upload files to your bucket
```bash
# Using AWS CLI
aws s3 cp myfile.txt s3://my-unique-bucket-ajay-2024/
aws s3 ls s3://my-unique-bucket-ajay-2024/
```

### 5. Destroy when done
```bash
# Empty the bucket first (can't delete non-empty buckets)
aws s3 rm s3://my-unique-bucket-ajay-2024/ --recursive
terraform destroy
```

## Files

| File | Purpose |
|------|---------|
| `main.tf` | Bucket + versioning + encryption + public access block |
| `variables.tf` | Region and bucket name |
| `terraform.tfvars` | **Your values here** |
| `outputs.tf` | Bucket name and ARN |
