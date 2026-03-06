variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name for the security group"
  default     = "my-devops-server"
}

variable "my_ip" {
  description = "Your IP for SSH access (format: x.x.x.x/32). Find at https://whatismyip.com"
  type        = string
  default     = "0.0.0.0/0"    # ⚠️ Change to your IP!
}
