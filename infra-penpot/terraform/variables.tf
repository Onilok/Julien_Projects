variable "region" {
  type    = string
  default = "eu-west-3"
}

variable "ssh_key_name" {
  type    = string
  default = "penpot-keys"
}

variable "allowed_ssh_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

