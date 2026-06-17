# modules/prometheus/variables.tf

variable "ami_id" {
  description = "Prometheus AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Type EC2"
  type        = string
  default     = "c7i-flex.large"
}

variable "ssh_key_name" {
  description = "Nom de la key pair SSH"
  type        = string
  default     = "prometheus-sshkey"
}

variable "private_subnets" {
  description = "Liste des subnets privés"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prometheus prefix"
  type        = string
  default     = "penpot-prometheus"
}

variable "root_volume_size" {
  description = "Root disk size in Go"
  type        = number
  default     = 30
}

variable "security_group_id" {
  description = "Security group ID prometheus"
  type        = string
}

