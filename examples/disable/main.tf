provider "aws" {
  version    = "~> 2"
  region     = "ca-central-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "disable" {
  source = "../../"

  enable = false
}
