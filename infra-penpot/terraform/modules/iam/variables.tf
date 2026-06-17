variable "name" {
  type        = string
  description = "Prefix for IAM resources"
}

variable "bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket to allow access to"
}

