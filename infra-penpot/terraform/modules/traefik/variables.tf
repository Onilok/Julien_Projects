# modules/bastion/variables.tf
variable "ami_id" {
  description = "AMI ID pour les traefik" 
  type        = string
  default = "ami-0808dd1ba12547041"
}

variable "instance_type" {
  description = "Type EC2"
  type        = string
  default     = "t3.micro"
}

variable "ssh_key_name" {
  description = "Nom de la key pair SSH"
  type        = string
  default     = "traefik-sshkey"
}

variable "public_subnets" {
  description = "Liste des subnets publics pour placer les traefik"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Liste des security groups à attacher"
  type        = list(string)
  default     = []
}

variable "name_prefix" {
  description = "Préfixe pour le nom des traefik"
  type        = string
  default     = "penpot-traefik"
}
