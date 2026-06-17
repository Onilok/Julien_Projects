# modules/prometheus/outputs.tf
output "instance_ids" {
  value = aws_instance.this[*].id
}

output "private_ips" {
  value = aws_instance.this[*].private_ip
}

output "instance_names" {
  value = aws_instance.this[*].tags["Name"]
  description = "Noms des instances prometheus"
}

output "ansible_user" {
  value = "admin"  # var.ansible_user 
}

