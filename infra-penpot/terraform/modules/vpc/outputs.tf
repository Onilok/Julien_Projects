output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

# IDs des subnets privés
output "private_subnets" {
  value       = aws_subnet.private[*].id
  description = "IDs des subnets privés"
}

# CIDRs des subnets privés
output "private_subnets_cidrs" {
  value       = aws_subnet.private[*].cidr_block
  description = "CIDRs des subnets privés"
}

# Table de routage unique pour tous les subnets privés
output "private_route_table_id" {
  value       = aws_route_table.private.id
  description = "ID de la table de routage pour les subnets privés"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "ID de l'Internet Gateway"
}

output "vpc_name" {
  value       = var.vpc_name
  description = "Nom du VPC"
}

# IDs des subnets privés secondaires
output "private_stg_subnets" {
  value       = aws_subnet.private_stg[*].id
  description = "IDs des subnets privés staging"
}

# CIDRs des subnets privés secondaires
output "private_stg_subnets_cidrs" {
  value       = aws_subnet.private_stg[*].cidr_block
  description = "CIDRs des subnets privés staging"
}


