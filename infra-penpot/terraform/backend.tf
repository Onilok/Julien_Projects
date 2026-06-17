terraform {
  backend "s3" {
    bucket  = "penpot-bucket-terraform"
    key     = "prod/terraform.tfstate"
    region  = "eu-west-3"
    encrypt = true
  }
}

