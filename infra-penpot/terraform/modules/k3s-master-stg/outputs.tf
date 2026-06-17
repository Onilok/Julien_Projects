# modules/k3s-master-stg/outputs.tf
output "master_instance_ids" {
  value = aws_instance.master[*].id
}

output "master_private_ips" {
  value = aws_instance.master[*].private_ip
}

output "master_names" {
  value = aws_instance.master[*].tags["Name"]
}

output "ansible_user" {
  value = "admin"
}

# -------------------------------
# Réseau 10.0.21.0/24

output "master_private_ips_10_0_21" {
  value = [
    for ip in aws_instance.master[*].private_ip : ip
    if startswith(ip, "10.0.21.")
  ]
}

output "master_instance_ids_10_0_21" {
  value = [
    for idx, ip in aws_instance.master[*].private_ip : aws_instance.master[idx].id
    if startswith(ip, "10.0.21.")
  ]
}

output "master_names_10_0_21" {
  value = [
    for idx, ip in aws_instance.master[*].private_ip : aws_instance.master[idx].tags["Name"]
    if startswith(ip, "10.0.21.")
  ]
}

# -------------------------------
# Réseau 10.0.22.0/24

output "master_private_ips_10_0_22" {
  value = [
    for ip in aws_instance.master[*].private_ip : ip
    if startswith(ip, "10.0.22.")
  ]
}

output "master_instance_ids_10_0_22" {
  value = [
    for idx, ip in aws_instance.master[*].private_ip : aws_instance.master[idx].id
    if startswith(ip, "10.0.22.")
  ]
}

output "master_names_10_0_22" {
  value = [
    for idx, ip in aws_instance.master[*].private_ip : aws_instance.master[idx].tags["Name"]
    if startswith(ip, "10.0.22.")
  ]
}


