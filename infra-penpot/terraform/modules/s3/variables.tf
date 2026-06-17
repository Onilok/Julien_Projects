variable "bucket_name" {
  type        = string
  description = "Base name for the S3 bucket"
}

variable "force_destroy" {
  type        = bool
  default     = false
}

variable "versioning" {
  type        = bool
  default     = true
}

variable "enable_lifecycle" {
  type        = bool
  default     = true
}

variable "transition_to_ia_days" {
  type    = number
  default = 30
}

variable "transition_to_glacier_days" {
  type    = number
  default = 90
}

variable "expiration_days" {
  type    = number
  default = 365
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "folders" {
  type    = list(string)
  default = []
}
