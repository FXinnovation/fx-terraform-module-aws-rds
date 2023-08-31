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

module "rds_cluster" {
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
  num_suffix_digits          = 3
  prefix                     = random_string.this.result
  tags = {
    terraformtest = true
  }

  #####
  # DB instance
  #####

  rds_instance_availability_zones = ["ca-central-1a", "ca-central-1b"]
  rds_instance_instance_classes   = ["db.t3.medium", "db.t3.medium"]
  rds_instance_promotion_tiers    = [0, 1]
  db_instance_global_tags = {
    dbglobaltags = "common"
  }
  db_instance_tags = [
    {
      dbinstancetag = "tftest"
    },
    {}
  ]

  #####
  # RDS cluster
  #####

  rds_cluster_identifier = "tftest"
  rds_cluster_tags = {
    dbclustertag = "tftest"
  }

  #####
  # DB subnet
  #####

  db_subnet_group_name = "tftest"
  db_subnet_group_tags = {
    dbsubnetgrouptag = "tftest"
  }
  db_subnet_group_subnet_ids = tolist(data.aws_subnet_ids.default.ids)

  #####
  # KMS key
  #####

  use_default_kms_key = true

  #####
  # Security group
  #####

  security_group_name = "tftest"
  allowed_cidrs       = ["127.0.0.1/32", "10.0.0.0/8"]
  security_group_tags = {
    dbsgtags = "tftest"
  }
  security_group_vpc_id = data.aws_vpc.default.id

  #####
  # SSM parameters
  #####

  create_ssm_parameters               = true
  ssm_parameters_use_database_kms_key = true
  ssm_parameters_prefix               = random_string.this.result
}
