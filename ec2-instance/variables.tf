# ============================================
# Variables — Change these values in terraform.tfvars
# ============================================

variable "aws_region" {
  description = "AWS region to create resources in (e.g., ap-south-1 for Mumbai)"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name tag for your EC2 instance (e.g., my-web-server)"
  type        = string
  default     = "my-ec2-server"
}

variable "ami_id" {
  description = "AMI ID for the OS image (Ubuntu 22.04 for ap-south-1)"
  type        = string
  default     = "ami-0f5ee92e2d63afc18"   # Ubuntu 22.04 LTS in ap-south-1
}

variable "instance_type" {
  description = "EC2 instance size (t2.micro = free tier, t2.medium = more power)"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of your AWS key pair (the .pem file you use to SSH)"
  type        = string
}

variable "volume_size" {
  description = "Disk space in GB"
  type        = number
  default     = 20
}

variable "my_ip" {
  description = "Your IP address for SSH access (format: x.x.x.x/32). Find it at https://whatismyip.com"
  type        = string
  default     = "0.0.0.0/0"   # WARNING: this allows SSH from anywhere. Use your actual IP!
}

variable "custom_port" {
  description = "Extra port to open (e.g., 8080 for Jenkins, 3000 for Grafana)"
  type        = number
  default     = 8080
}
