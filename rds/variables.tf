variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name for the RDS instance"
  default     = "my-database"
}

variable "db_engine" {
  description = "Database engine: 'mysql' or 'postgres'"
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Database version (e.g., '8.0' for MySQL, '15' for PostgreSQL)"
  default     = "8.0"
}

variable "db_instance_class" {
  description = "RDS instance size (db.t3.micro = free tier eligible)"
  default     = "db.t3.micro"
}

variable "db_storage" {
  description = "Storage in GB"
  default     = 20
}

variable "db_max_storage" {
  description = "Max storage for auto-scaling in GB"
  default     = 50
}

variable "db_name" {
  description = "Name of the default database"
  default     = "myapp"
}

variable "db_username" {
  description = "Master username for the database"
  default     = "admin"
}

variable "db_password" {
  description = "Master password — ⚠️ use a strong password!"
  type        = string
  sensitive   = true    # Terraform won't show this in output
}

variable "db_port" {
  description = "Database port (MySQL=3306, PostgreSQL=5432)"
  default     = 3306
}

variable "allowed_cidr" {
  description = "IP range allowed to connect (e.g., your EC2's security group)"
  default     = "0.0.0.0/0"   # ⚠️ CHANGE THIS for production
}

variable "publicly_accessible" {
  description = "Allow public access (set false for production)"
  default     = true
}
