output "vpc_id" {
  value = module.vpc.vpc_id
}

#output "NLB DNS name"
output "nlb_dns_name" {
  description = "Le DNS du NLB"
  value       = module.nlb.dns_name
}

#output "bastion_instance_ids" {
#  value = module.bastion.instance_ids
#}

#output "Bastion public ip" 
output "bastion_public_ips" {
  value = module.bastion.public_ips
}

# output for ansible "ansible_user" 
output "bastion_ansible_user" {
  value = module.bastion.ansible_user
}

#output "bastion_private_ips" {
#  value = module.bastion.private_ips
#}

output "bastion_instance_names" {
  value = module.bastion.instance_names
}

output "traefik_instance_names" {
  value = module.traefik.instance_names
}

output "traefik_private_ips" {
  value = module.traefik.private_ips
}

#output "traefik_public_ips" {
#  value = module.traefik.public_ips
#}

output "traefik_ansible_user" {
  value = module.traefik.ansible_user
}

# IDs PRD K3s masters instances
output "k3s_master_instance_ids" {
  description = "List of Prd IDs instances K3s Masters"
  value       = module.k3s_masters.master_instance_ids
}

# IDs STG K3s masters instances
output "k3s_master_stg_instance_ids" {
  description = "List of Stg IDs instances K3s Masters"
  value       = module.k3s_masters_stg.master_instance_ids
}

# IDs STG K3s workers instances
output "k3s_worker_stg_instance_ids" {
  description = "List of Stg IDs instances K3s Workers"
  value       = module.k3s_workers_stg.worker_instance_ids
}

# Private IP of PRD masters
output "k3s_master_prd_private_ips" {
  description = "List of privates IP of K3s Prd Masters"
  value       = module.k3s_masters.master_private_ips
}

# Private IP of STG masters
output "k3s_master_stg_private_ips" {
  description = "List of privates IP of K3s stg Masters"
  value       = module.k3s_masters_stg.master_private_ips
}

# Private IP of STG workers
output "k3s_worker_stg_private_ips" {
  description = "List of privates IP of K3s stg Workers"
  value       = module.k3s_workers_stg.worker_private_ips
}

output "k3s_master_ansible_user" {
  value = module.k3s_masters.ansible_user
}

# Noms des instances
output "k3s_master_names" {
  description = "Liste des noms des instances K3s Masters"
  value       = module.k3s_masters.master_names
}

# K3s masters - Prd network 10.0.11.0/24
output "k3s_master_private_ips_10_0_11" {
  description = "IPs private of masters K3s prd subnet 10.0.11.0/24"
  value       = module.k3s_masters.master_private_ips_10_0_11
}

# K3s masters - Prd network 10.0.12.0/24
output "k3s_master_private_ips_10_0_12" {
  description = "IPs private of masters K3s prd subnet 10.0.12.0/24"
  value       = module.k3s_masters.master_private_ips_10_0_12
}

# K3s masters - Stg network 10.0.21.0/24
output "k3s_master_private_ips_10_0_21" {
  description = "IPs private of masters k3s stg subnet 10.0.21.0/24"
  value       = module.k3s_masters_stg.master_private_ips_10_0_21
}

# K3s masters - Stg network 10.0.22.0/24
output "k3s_master_private_ips_10_0_22" {
  description = "IPs private of masters k3s stg subnet 10.0.22.0/24"
  value       = module.k3s_masters_stg.master_private_ips_10_0_22
}

# Prometheus output
output "prometheus_instance_ids" {
  value = module.prometheus.instance_ids
}

output "prometheus_private_ips" {
  value = module.prometheus.private_ips
}

# penpot-user for S3 bucket access
output "penpot_access_key_id" {
  value     = module.penpot_s3_auth.penpot_aws_access_key_id
  sensitive = true
}

output "penpot_secret_access_key" {
  value     = module.penpot_s3_auth.penpot_aws_secret_access_key
  sensitive = true
}

output "penpot_user_name" {
  value = module.penpot_s3_auth.penpot_user_name
}

# Private subnets stg 
output "private_stg_subnets" {
  value = module.vpc.private_stg_subnets
}

output "private_stg_subnets_cidrs" {
  value = module.vpc.private_stg_subnets_cidrs
}

