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

module "kms_key" {
  source = "../../"

  #####
  # Common
  #####

  engine                     = "aurora-mysql"
  engine_version             = "5.7.mysql_aurora.2.07.1"
  deletion_protection        = false
  apply_immediately          = true
  auto_minor_version_upgrade = true
  database_identifier        = "tftest"
  database_name              = format("%s%s", random_string.this.result, "tftest")
  master_password            = format("%s%s", random_string.this.result, "tftest")
  master_username            = format("%s%s", random_string.this.result, "tftest")
  use_num_suffix             = true
  prefix                     = random_string.this.result
  tags = {
    terraformtest = true
  }

  #####
  # DB instance
  #####

  db_instance_availability_zones = ["ca-central-1a"]
  db_instance_instance_classes   = ["db.t3.medium"]
  db_instance_promotion_tiers    = [0]

  #####
  # RDS cluster
  #####

  rds_cluster_identifier          = "tftest"
  rds_cluster_skip_final_snapshot = true

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

  security_group_name         = "tftest"
  security_group_source_cidrs = ["127.0.0.1/32", "10.0.0.0/8"]
  security_group_vpc_id       = data.aws_vpc.default.id
}
