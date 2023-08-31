
terraform {
  required_version = ">= 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.57"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}
