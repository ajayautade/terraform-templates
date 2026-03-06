output "security_group_id" {
  description = "ID of the security group — use this in EC2 or other templates"
  value       = aws_security_group.main.id
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.main.name
}
