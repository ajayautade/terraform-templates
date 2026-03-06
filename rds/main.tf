# ============================================
# Terraform Template: RDS Database
# Creates a managed MySQL or PostgreSQL database
# AWS handles backups, patching, and maintenance
# ============================================

provider "aws" {
  region = var.aws_region
}

# --- Security Group for RDS ---
# Controls which IPs/servers can connect to your database
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow database connections"

  # Allow database connections on the DB port
  ingress {
    description = "Database port"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]   # Which IPs can connect
  }

  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

# --- RDS Database Instance ---
# This creates the actual managed database
resource "aws_db_instance" "database" {
  identifier     = var.project_name           # Unique name for this RDS instance
  engine         = var.db_engine              # "mysql" or "postgres"
  engine_version = var.db_engine_version      # Version of the database
  instance_class = var.db_instance_class      # Server size (db.t3.micro = free tier)

  allocated_storage     = var.db_storage      # Disk space in GB
  max_allocated_storage = var.db_max_storage  # Auto-scale storage up to this

  db_name  = var.db_name          # Name of the default database
  username = var.db_username      # Master username
  password = var.db_password      # Master password — ⚠️ keep this secret!

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Backup settings
  backup_retention_period = 7     # Keep backups for 7 days
  skip_final_snapshot     = true  # Don't create snapshot when deleting (set false for production!)

  # Make it publicly accessible (set false for production — use VPC instead)
  publicly_accessible = var.publicly_accessible

  tags = {
    Name = "${var.project_name}-rds"
  }
}
