provider "aws" {
  version    = "~> 2"
  region     = "ca-central-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
  number  = false
}


resource "aws_security_group" "example" {
  name        = format("%s%s", random_string.this.result, "tftest")
  description = format("%s%s", random_string.this.result, "tftest")
  vpc_id      = data.aws_vpc.default.id
  tags = {
    tftest = true
  }
}

resource "aws_kms_key" "example" {
  tags = {
    tftest = true
  }
}

resource "aws_db_subnet_group" "this" {

  name       = random_string.this.result
  subnet_ids = tolist(data.aws_subnet_ids.default.ids)
  tags = {
    tftest = true
  }
}

module "external_kms_external_security_group_no_subnet_group" {
  source = "../../"

  #####
  # Common
  #####

  engine                     = "aurora-mysql"
  engine_version             = "5.7.mysql_aurora.2.07.1"
  deletion_protection        = false
  additionnal_security_group = [aws_security_group.example.id]
  apply_immediately          = true
  auto_minor_version_upgrade = false
  database_identifier        = random_string.this.result
  master_password            = format("%s%s", random_string.this.result, "tftest")
  master_username            = format("%s%s", random_string.this.result, "tftest")
  skip_final_snapshot        = true
  use_num_suffix             = false
  prefix                     = random_string.this.result

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

  db_subnet_group_name = aws_db_subnet_group.this.id

  #####
  # DB cluster parameter group
  #####

  parameter_group_family = "aurora-mysql5.7"
  parameter_group_name   = "tftest"
  parameter_group_parameters = [
    {
      name         = "aurora_lab_mode"
      value        = "1"
      apply_method = "pending-reboot"
    },
    {
      name         = "innodb_adaptive_max_sleep_delay"
      value        = "20"
      apply_method = null
    }
  ]
  parameter_group_tags = {
    tftest = true
  }

  #####
  # KMS key
  #####

  use_default_kms_key = false
  kms_key_id          = aws_kms_key.example.key_id
}
