variable "name" {
  description = "Prefixe pour nommer les ressources NAT"
  type        = string
}

variable "public_subnet_id" {
  description = "ID du subnet public où placer la NAT Gateway"
  type        = string
}

variable "private_route_table_id" {
  description = "ID de la route table privée à mettre à jour"
  type        = string
}

variable "internet_gateway_id" {
  description = "ID de l'Internet Gateway associée au VPC"
  type        = string
}

