# ============================================
# Terraform Template: Security Group
# A Security Group is like a firewall for your AWS resources
# It controls which traffic is allowed IN and OUT
# ============================================

provider "aws" {
  region = var.aws_region
}

# --- Security Group ---
resource "aws_security_group" "main" {
  name        = "${var.project_name}-sg"
  description = "Security group for ${var.project_name}"

  # --- INBOUND RULES (who can connect to your server) ---

  # Allow SSH (port 22) — so you can connect to the server
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]    # Only YOUR IP can SSH in
  }

  # Allow HTTP (port 80) — for websites
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Anyone can access the website
  }

  # Allow HTTPS (port 443) — for secure websites
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Jenkins (port 8080)
  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Grafana (port 3000)
  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Prometheus (port 9090)
  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SonarQube (port 9000)
  ingress {
    description = "SonarQube"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # --- OUTBOUND RULES (what your server can connect to) ---

  # Allow ALL outgoing traffic (so server can download packages, updates, etc.)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}
