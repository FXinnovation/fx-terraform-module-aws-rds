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
  name        = format("%s%s", random_string.this.result, "tftest-option-group")
  description = format("%s%s", random_string.this.result, "tftest-option-group")
  vpc_id      = data.aws_vpc.default.id
  tags = {
    tftest = true
  }
}

module "db_instance_with_option_group" {
  source = "../../"

  #####
  # Common
  #####

  engine                     = "mysql"
  engine_version             = "5.7.19"
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

  #####
  # DB instance
  #####

  db_instance_instance_class              = "db.t3.large"
  db_instance_availability_zone           = element(data.aws_availability_zones.available.names, 0)
  db_instance_allocated_storage           = 5
  db_instance_allow_major_version_upgrade = false
  db_instance_max_allocated_storage       = 20
  db_instance_multi_az                    = false
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

  use_default_kms_key = true

  #####
  # Security group
  #####

  security_group_name         = "tftest"
  security_group_source_cidrs = ["127.0.0.1/32", "10.0.0.0/8"]
  security_group_tags = {
    dbsgtags = "tftest"
  }
  security_group_vpc_id = data.aws_vpc.default.id

  #####
  # DB option group
  #####

  option_group_name                 = "tftest"
  option_group_engine_name          = "mysql"
  option_group_major_engine_version = "5.7"
  option_group_options = [
    {
      option_name                    = "MEMCACHED",
      port                           = 11211,
      vpc_security_group_memberships = [aws_security_group.example.id],
      option_settings = [
        {
          name  = "INNODB_API_DISABLE_ROWLOCK",
          value = "1",
        },
        {
          name  = "DAEMON_MEMCACHED_W_BATCH_SIZE",
          value = "42",
        }
      ],
    },
    {
      option_name = "MARIADB_AUDIT_PLUGIN",
      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS",
          value = "QUERY",
        }
      ]
    }
  ]

  #####
  # SSM parameters
  #####

  create_ssm_parameters = true

  ssm_parameters_prefix = random_string.this.result

  ssm_parameters_export_master_password    = false
  ssm_parameters_export_database_name      = false
  ssm_parameters_export_character_set_name = false
  ssm_parameters_export_endpoint_reader    = false

  ssm_parameters_kms_key_create     = true
  ssm_parameters_kms_key_name       = "tftest-ssm"
  ssm_parameters_kms_key_alias_name = "tftest-ssm"
}
