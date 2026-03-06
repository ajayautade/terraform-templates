variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name prefix for all resources"
  default     = "my-project"
}

variable "vpc_cidr" {
  description = "IP range for the VPC (e.g., 10.0.0.0/16 gives you 65,000+ IPs)"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "IP range for public subnet 1"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "IP range for public subnet 2"
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "IP range for private subnet 1"
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "IP range for private subnet 2"
  default     = "10.0.4.0/24"
}
