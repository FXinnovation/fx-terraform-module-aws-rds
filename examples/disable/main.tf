provider "aws" {
  region = "ca-central-1"

  assume_role {
    role_arn     = "arn:aws:iam::700633540182:role/Jenkins"
    session_name = "FXTestSandbox"
  }
}

module "disable" {
  source = "../../"

  enable = false
}
