output "rds_endpoint" {
  description = "Database connection endpoint (host:port)"
  value       = aws_db_instance.database.endpoint
}

output "rds_port" {
  description = "Database port"
  value       = aws_db_instance.database.port
}

output "connection_string" {
  description = "Use this to connect from your app"
  value       = "${var.db_engine}://${var.db_username}:<password>@${aws_db_instance.database.endpoint}/${var.db_name}"
}
