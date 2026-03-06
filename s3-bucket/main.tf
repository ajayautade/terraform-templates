# ============================================
# Terraform Template: S3 Bucket
# Creates an S3 bucket with:
# - Versioning (keeps old versions of files)
# - Encryption (data is encrypted at rest)
# - Block public access (prevents accidental exposure)
# ============================================

provider "aws" {
  region = var.aws_region
}

# --- S3 Bucket ---
# S3 = Simple Storage Service — stores files (objects) in the cloud
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name   # Must be globally unique across ALL AWS accounts

  tags = {
    Name = var.bucket_name
  }
}

# --- Enable Versioning ---
# Keeps every version of a file, so you can recover deleted/overwritten files
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# --- Enable Encryption ---
# Encrypts all files stored in the bucket (security best practice)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"   # Free, built-in AWS encryption
    }
  }
}

# --- Block Public Access ---
# Prevents anyone from accidentally making the bucket public
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true    # Block public ACLs
  block_public_policy     = true    # Block public bucket policies
  ignore_public_acls      = true    # Ignore any existing public ACLs
  restrict_public_buckets = true    # Restrict public bucket policies
}
