variable "vpc_name" {
  type    = string
  default = "penpot-vpc"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["eu-west-3a", "eu-west-3b"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_subnet_secondary_cidrs" {
  type = list(string)
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}

