provider "aws" {
  region = "ca-central-1"

  assume_role {
    role_arn     = "arn:aws:iam::700633540182:role/Jenkins"
    session_name = "FXTestSandbox"
  }
}

resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
  numeric = false
}

resource "aws_security_group" "example" {
  name        = format("%s%s", random_string.this.result, "tftest-option-group")
  description = format("%s%s", random_string.this.result, "tftest-option-group")
  vpc_id      = data.aws_vpc.default.id
  tags = {
    tftest = true
  }
}

module "kms_key" {
  source = "../../"

  #####
  # Common
  #####

  engine                     = "aurora-mysql"
  engine_version             = "5.7.mysql_aurora.3.02.0"
  deletion_protection        = false
  apply_immediately          = true
  auto_minor_version_upgrade = true
  database_identifier        = "tftest"
  database_name              = format("%s%s", random_string.this.result, "tftest")
  master_password            = format("%s%s", random_string.this.result, "tftest")
  master_username            = format("%s%s", random_string.this.result, "tftest")
  skip_final_snapshot        = true
  use_num_suffix             = true
  prefix                     = random_string.this.result
  tags = {
    terraformtest = true
  }

  #####
  # DB instance
  #####

  rds_instance_availability_zones = ["ca-central-1a"]
  rds_instance_instance_classes   = ["db.t3.medium"]
  rds_instance_promotion_tiers    = [0]

  #####
  # RDS cluster
  #####

  rds_cluster_identifier = "tftest"

  #####
  # DB subnet
  #####

  db_subnet_group_name       = "tftest"
  db_subnet_group_subnet_ids = tolist(data.aws_subnet_ids.default.ids)

  #####
  # KMS key
  #####

  use_default_kms_key  = false
  kms_key_alias_name   = "tftest"
  kms_key_create       = true
  kms_key_create_alias = true
  kms_key_name         = "tftest"
  kms_key_tags = {
    kmskeytag = "foo"
  }

  #####
  # Security group
  #####

  security_group_name                = "tftest"
  allowed_cidrs                      = ["127.0.0.1/32", "10.0.0.0/8"]
  security_group_vpc_id              = data.aws_vpc.default.id
  allowed_security_group_ids         = [aws_security_group.example.id]
  allowed_security_group_ids_count   = 1
  manage_client_security_group_rules = false


  #####
  # SSM parameters
  #####

  create_ssm_parameters              = true
  ssm_parameters_use_default_kms_key = true
  ssm_parameters_prefix              = random_string.this.result

}
