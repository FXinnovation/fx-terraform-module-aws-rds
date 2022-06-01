provider "aws" {
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

module "db_instance" {
  source = "../../"

  #####
  # Common
  #####

  engine                     = "postgres"
  engine_version             = "14.2"
  deletion_protection        = false
  apply_immediately          = true
  auto_minor_version_upgrade = false
  database_identifier        = "tftest"
  database_name              = format("%s%s", random_string.this.result, "tftest")
  master_password            = format("%s%s", random_string.this.result, "tftest")
  master_username            = format("%s%s", random_string.this.result, "tftest")
  backup_retention_period    = 0
  skip_final_snapshot        = true
  use_num_suffix             = true
  prefix                     = random_string.this.result

  #####
  # DB instance
  #####

  db_instance_instance_class              = "db.t3.large"
  db_instance_allocated_storage           = 5
  db_instance_allow_major_version_upgrade = false
  db_instance_max_allocated_storage       = 20
  db_instance_multi_az                    = true
  db_instance_storage_type                = "gp2"

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

  use_default_kms_key  = false
  kms_key_name         = "tftest"
  kms_key_create       = true
  kms_key_create_alias = false

  #####
  # Security group
  #####

  security_group_name                = "tftest"
  allowed_cidrs                      = ["127.0.0.1/32", "10.0.0.0/8"]
  manage_client_security_group_rules = false
  security_group_tags = {
    dbsgtags = "tftest"
  }
  security_group_vpc_id = data.aws_vpc.default.id

  #####
  # SSM parameters
  #####

  create_ssm_parameters = true

  ssm_parameters_use_database_kms_key = true

  ssm_parameters_prefix = random_string.this.result

  ssm_parameters_endpoint_key_name = "endpointURL"

  ssm_parameters_iam_policy_create                 = true
  ssm_parameters_iam_policy_name_prefix_read_only  = "tftestRO"
  ssm_parameters_iam_policy_name_prefix_read_write = "tftestRW"

  ssm_parameters_tags = {
    ssmTags = "foo"
  }
}
