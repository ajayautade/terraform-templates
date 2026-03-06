# ============================================
# Outputs — Shows useful info after terraform apply
# ============================================

output "instance_id" {
  description = "The ID of your EC2 instance"
  value       = aws_instance.server.id
}

output "public_ip" {
  description = "Public IP address — use this to SSH or access your app"
  value       = aws_instance.server.public_ip
}

output "ssh_command" {
  description = "Copy-paste this to SSH into your server"
  value       = "ssh -i ${var.key_pair_name}.pem ubuntu@${aws_instance.server.public_ip}"
}
