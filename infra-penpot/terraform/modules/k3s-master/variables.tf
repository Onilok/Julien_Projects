# modules/k3s-master/variables.tf

variable "ami_id" {
  description = "AMI ID pour les masters"
  type        = string
}

variable "instance_type" {
  description = "Type EC2"
  type        = string
  default     = "m7i-flex.large"
}

variable "ssh_key_name" {
  description = "Nom de la key pair SSH"
  type        = string
  default     = "k3s-sshkey"
}

variable "private_subnets" {
  description = "Liste des subnets privés"
  type        = list(string)
}

variable "name_prefix" {
  description = "Préfixe pour nommer les masters"
  type        = string
  default     = "k3s-master"
}

variable "root_volume_size" {
  description = "Taille du disque root en Go"
  type        = number
  default     = 30
}

variable "security_group_id" {
  description = "Security group ID pour les masters"
  type        = string
}

