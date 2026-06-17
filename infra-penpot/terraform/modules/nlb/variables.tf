variable "nlb_name" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

# Ajout

#variable "traefik_instance_ids" {
#  description = "Liste des EC2 Traefik"
#  type        = list(string)
#}

