variable "bucket_name" {
  description = "Nom du bucket S3 que Penpot doit utiliser"
  type        = string
}

variable "user_name" {
  description = "Nom de l'utilisateur IAM pour Penpot"
  type        = string
  default     = "penpot"
}

