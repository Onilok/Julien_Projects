# modules/k3s-worker-stg/outputs.tf
output "worker_instance_ids" {
  value = aws_instance.worker[*].id
}

output "worker_private_ips" {
  value = aws_instance.worker[*].private_ip
}

output "worker_names" {
  value = aws_instance.worker[*].tags["Name"]
}

output "ansible_user" {
  value = "admin"
}

# -------------------------------
# Réseau 10.0.21.0/24

output "worker_private_ips_10_0_21" {
  value = [
    for ip in aws_instance.worker[*].private_ip : ip
    if startswith(ip, "10.0.21.")
  ]
}

output "worker_instance_ids_10_0_21" {
  value = [
    for idx, ip in aws_instance.worker[*].private_ip : aws_instance.worker[idx].id
    if startswith(ip, "10.0.21.")
  ]
}

output "worker_names_10_0_21" {
  value = [
    for idx, ip in aws_instance.worker[*].private_ip : aws_instance.worker[idx].tags["Name"]
    if startswith(ip, "10.0.21.")
  ]
}

# -------------------------------
# Réseau 10.0.22.0/24

output "master_private_ips_10_0_22" {
  value = [
    for ip in aws_instance.worker[*].private_ip : ip
    if startswith(ip, "10.0.22.")
  ]
}

output "master_instance_ids_10_0_22" {
  value = [
    for idx, ip in aws_instance.worker[*].private_ip : aws_instance.worker[idx].id
    if startswith(ip, "10.0.22.")
  ]
}

output "master_names_10_0_22" {
  value = [
    for idx, ip in aws_instance.worker[*].private_ip : aws_instance.worker[idx].tags["Name"]
    if startswith(ip, "10.0.22.")
  ]
}


