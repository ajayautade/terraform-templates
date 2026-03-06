variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "S3 bucket name (must be globally unique — add your name or random chars)"
  type        = string
}
