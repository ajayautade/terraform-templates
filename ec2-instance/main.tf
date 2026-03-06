# ============================================
# Terraform Template: EC2 Instance
# Creates a single EC2 server with a security group
# ============================================

# Tell Terraform we're using AWS
provider "aws" {
  region = var.aws_region   # Which AWS region to create resources in
}

# --- Security Group ---
# This is like a firewall for your EC2 instance
# It controls which ports are open for incoming/outgoing traffic
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for ${var.project_name} EC2 instance"

  # Allow SSH access (port 22) — so you can connect to the server
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]   # Only allow YOUR IP address
  }

  # Allow HTTP traffic (port 80) — for web servers
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # Allow from anywhere
  }

  # Allow HTTPS traffic (port 443)
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow custom port (e.g., 8080 for Jenkins)
  ingress {
    description = "Custom Port"
    from_port   = var.custom_port
    to_port     = var.custom_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ALL outgoing traffic (so the server can download packages, etc.)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

# --- EC2 Instance ---
# This creates the actual virtual server
resource "aws_instance" "server" {
  ami           = var.ami_id           # The OS image (Ubuntu, Amazon Linux, etc.)
  instance_type = var.instance_type    # Server size (t2.micro = free tier, t2.medium = bigger)
  key_name      = var.key_pair_name    # SSH key pair to connect to the server

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]   # Attach the security group above

  # Storage — how much disk space
  root_block_device {
    volume_size = var.volume_size   # Size in GB
    volume_type = "gp3"            # gp3 = fast SSD storage
  }

  tags = {
    Name = var.project_name
  }
}
