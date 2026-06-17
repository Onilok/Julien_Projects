# modules/bastion/outputs.tf
output "instance_ids" {
  value = aws_instance.this[*].id
}

output "public_ips" {
  value = aws_instance.this[*].public_ip
}

output "private_ips" {
  value = aws_instance.this[*].private_ip
}

output "instance_names" {
  value = aws_instance.this[*].tags["Name"]
  description = "Noms des instances bastion"
}

output "ansible_user" {
  value = "bastion"  # ou var.ansible_user si tu veux paramétrer
}


