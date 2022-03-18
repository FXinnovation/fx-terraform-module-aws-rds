locals {
  tags = {
    managed-by = "terraform"
    Terraform  = "True"
  }
  description = format("For %s %s", local.is_aurora ? "RDS cluster" : "DB instance", var.database_identifier)
  is_aurora   = replace(var.engine != null ? var.engine : "", "/^aurora{1}.*$/", "1") == "1" ? true : false
  kms_key_id  = var.kms_key_create ? element(concat(aws_kms_key.this.*.arn, [""]), 0) : var.use_default_kms_key ? null : var.kms_key_id
}

resource "random_id" "final_snapshot" {
  count = var.enable && var.final_snapshot_identifier_prefix != null ? 1 : 0

  // To create this list, please select all parameters with the flag ForceNew on those pages :
  // https://github.com/terraform-providers/terraform-provider-aws/blob/master/aws/resource_aws_rds_cluster.go
  // https://github.com/terraform-providers/terraform-provider-aws/blob/master/aws/resource_aws_db_instance.go
  keepers = {
    cluster_identifier    = var.rds_cluster_identifier
    database_name         = var.database_name
    db_subnet_group_name  = local.db_subnet_group_needed ? element(concat(aws_db_subnet_group.this.*.name, [""]), 0) : var.db_subnet_group_name
    engine                = var.engine
    engine_mode           = var.engine_mode
    bucket_name           = var.s3_import_bucket_name
    bucket_prefix         = var.s3_import_bucket_prefix
    ingestion_role        = var.s3_import_ingestion_role
    source_engine         = var.s3_import_source_engine
    source_engine_version = var.s3_import_source_engine_version
    master_username       = var.master_username
    port                  = var.port
    kms_key_id            = var.kms_key_create ? element(concat(aws_kms_key.this.*.arn, [""]), 0) : var.use_default_kms_key ? var.kms_key_id : null
    source_region         = var.rds_cluster_source_region
    character_set_name    = var.db_instance_character_set_name
    availability_zone     = var.db_instance_availability_zone
    snapshot_identifier   = var.snapshot_identifier
    timezone              = var.db_instance_timezone
  }

  byte_length = 5
}

#####
# Common resources
#####

locals {
  db_subnet_group_needed = length(var.db_subnet_group_subnet_ids) > 0
}

resource "aws_db_subnet_group" "this" {
  count = var.enable && local.db_subnet_group_needed ? 1 : 0

  name        = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.db_subnet_group_name, count.index + 1) : format("%s%s", var.prefix, var.db_subnet_group_name)
  description = local.description
  subnet_ids  = var.db_subnet_group_subnet_ids
  tags = merge(
    var.tags,
    var.db_subnet_group_tags,
    {
      Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.db_subnet_group_name, count.index + 1) : format("%s%s", var.prefix, var.db_subnet_group_name)
    },
    local.tags,
  )
}


#####
# KMS Key
#####

resource "aws_kms_key" "this" {
  count = var.enable && var.kms_key_create ? 1 : 0

  description = local.description
  policy      = var.kms_key_policy_json

  tags = merge(
    var.tags,
    var.kms_key_tags,
    {
      "Name" = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.kms_key_name, count.index + 1) : format("%s%s", var.prefix, var.kms_key_name)
    },
    local.tags,
  )
}

resource "aws_kms_alias" "this" {
  count = var.enable && var.kms_key_create && var.kms_key_create_alias ? 1 : 0

  name          = var.use_num_suffix ? format("alias/%s%s-%0${var.num_suffix_digits}d", var.prefix, var.kms_key_alias_name, count.index + 1) : format("alias/%s%s", var.prefix, var.kms_key_alias_name)
  target_key_id = element(concat(aws_kms_key.this.*.key_id, [""]), 0)
}

#####
# RDS cluster
#####

resource "aws_rds_cluster" "this" {
  count = var.enable && local.is_aurora ? 1 : 0

  cluster_identifier = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.rds_cluster_identifier, count.index + 1) : format("%s%s", var.prefix, var.rds_cluster_identifier)

  source_region                   = var.rds_cluster_source_region
  db_subnet_group_name            = local.db_subnet_group_needed ? element(concat(aws_db_subnet_group.this.*.name, [""]), 0) : var.db_subnet_group_name
  db_cluster_parameter_group_name = local.rds_cluster_parameter_group_needed ? element(concat(aws_rds_cluster_parameter_group.this.*.id, [""]), 0) : var.parameter_group_name

  copy_tags_to_snapshot = var.copy_tags_to_snapshot

  database_name          = var.database_name
  master_username        = var.master_username
  master_password        = var.master_password
  port                   = var.port
  vpc_security_group_ids = concat(aws_security_group.this.*.id, var.additionnal_security_group)

  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier_prefix != null ? format("%s%s-%s", var.prefix, var.final_snapshot_identifier_prefix, element(concat(random_id.final_snapshot.*.dec, [""]), 0)) : null

  snapshot_identifier = var.snapshot_identifier

  backtrack_window             = var.backtrack_window
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  apply_immediately            = var.apply_immediately


  global_cluster_identifier     = var.rds_cluster_global_cluster_identifier
  replication_source_identifier = var.rds_cluster_replication_source_identifier


  storage_encrypted = true
  kms_key_id        = local.kms_key_id

  iam_roles                           = var.rds_cluster_iam_roles
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  engine                          = var.engine
  engine_mode                     = var.engine_mode
  engine_version                  = var.engine_version
  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports

  dynamic "scaling_configuration" {
    for_each = var.rds_cluster_enable_scaling_configuration ? [1] : []

    content {
      auto_pause               = var.rds_cluster_scaling_configuration_auto_pause
      max_capacity             = var.rds_cluster_scaling_configuration_max_capacity
      min_capacity             = var.rds_cluster_scaling_configuration_min_capacity
      seconds_until_auto_pause = var.rds_cluster_scaling_configuration_seconds_until_auto_pause
      timeout_action           = var.rds_cluster_scaling_configuration_timeout_action
    }
  }

  dynamic "s3_import" {
    for_each = var.enable_s3_import ? [1] : []

    content {
      source_engine         = var.s3_import_source_engine
      source_engine_version = var.s3_import_source_engine_version
      bucket_name           = var.s3_import_bucket_name
      bucket_prefix         = var.s3_import_bucket_prefix
      ingestion_role        = var.s3_import_ingestion_role
    }
  }

  enable_http_endpoint = var.rds_cluster_enable_http_endpoint

  tags = merge(
    var.tags,
    var.rds_cluster_tags,
    {
      Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.rds_cluster_identifier, count.index + 1) : format("%s%s", var.prefix, var.rds_cluster_identifier)
    },
    local.tags,
  )
}


resource "aws_rds_cluster_instance" "this" {
  count = var.enable && local.is_aurora ? length(var.rds_instance_instance_classes) : 0

  identifier                      = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.database_identifier, (count.index + 1)) : format("%s%s-%02d", var.prefix, var.database_identifier, count.index + 1)
  cluster_identifier              = element(concat(aws_rds_cluster.this.*.id, [""]), 0)
  engine                          = var.engine
  engine_version                  = var.engine_version
  instance_class                  = var.rds_instance_instance_classes[count.index]
  publicly_accessible             = var.publicly_accessible
  db_subnet_group_name            = local.db_subnet_group_needed ? element(concat(aws_db_subnet_group.this.*.name, [""]), 0) : var.db_subnet_group_name
  apply_immediately               = var.apply_immediately
  monitoring_role_arn             = var.monitoring_role_arn
  monitoring_interval             = var.monitoring_interval
  promotion_tier                  = var.rds_instance_promotion_tiers != null ? var.rds_instance_promotion_tiers[count.index] : null
  availability_zone               = var.rds_instance_availability_zones[count.index]
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  ca_cert_identifier              = var.ca_cert_identifier
  tags = merge(
    var.tags,
    var.db_instance_global_tags,
    length(var.db_instance_tags) > 0 ? var.db_instance_tags[count.index] : {},
    {
      Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.database_identifier, (count.index + 1)) : format("%s%s", var.prefix, var.database_identifier)
    },
    local.tags,
  )
}

locals {
  rds_cluster_parameter_group_needed = local.is_aurora && length(var.parameter_group_parameters) > 0
}

resource "aws_rds_cluster_parameter_group" "this" {
  count = var.enable && local.rds_cluster_parameter_group_needed ? 1 : 0

  name        = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.parameter_group_name, count.index + 1) : format("%s%s", var.prefix, var.parameter_group_name)
  family      = var.parameter_group_family
  description = local.description

  dynamic "parameter" {
    for_each = var.parameter_group_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = merge(
    var.tags,
    var.parameter_group_tags,
    {
      Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.parameter_group_name, count.index + 1) : format("%s%s", var.prefix, var.parameter_group_name)
    },
    local.tags,
  )
}

#####
# DB instance
#####

resource "aws_db_instance" "this" {
  count = var.enable && ! local.is_aurora ? 1 : 0

  allocated_storage                     = var.db_instance_allocated_storage
  allow_major_version_upgrade           = var.db_instance_allow_major_version_upgrade
  apply_immediately                     = var.apply_immediately
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  availability_zone                     = var.db_instance_availability_zone
  backup_retention_period               = var.backup_retention_period
  backup_window                         = var.preferred_backup_window
  ca_cert_identifier                    = var.ca_cert_identifier
  character_set_name                    = var.db_instance_character_set_name
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  db_subnet_group_name                  = local.db_subnet_group_needed ? element(concat(aws_db_subnet_group.this.*.name, [""]), 0) : var.db_subnet_group_name
  delete_automated_backups              = var.db_instance_delete_automated_backups
  deletion_protection                   = var.deletion_protection
  domain                                = var.db_instance_domain
  domain_iam_role_name                  = var.db_instance_domain_iam_role_name
  enabled_cloudwatch_logs_exports       = var.cloudwatch_logs_exports
  engine                                = var.engine
  engine_version                        = var.engine_version
  final_snapshot_identifier             = var.final_snapshot_identifier_prefix != null ? format("%s%s-%s", var.prefix, var.final_snapshot_identifier_prefix, element(concat(random_id.final_snapshot.*.dec, [""]), 0)) : null
  iam_database_authentication_enabled   = var.iam_database_authentication_enabled
  identifier                            = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.database_identifier, (count.index + 1)) : format("%s%s-%02d", var.prefix, var.database_identifier, count.index + 1)
  instance_class                        = var.db_instance_instance_class
  iops                                  = var.db_instance_iops
  kms_key_id                            = local.kms_key_id
  license_model                         = var.db_instance_license_model
  maintenance_window                    = var.preferred_maintenance_window
  max_allocated_storage                 = var.db_instance_max_allocated_storage
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_arn                   = var.monitoring_role_arn
  multi_az                              = var.db_instance_multi_az
  name                                  = var.database_name
  option_group_name                     = local.db_option_group_needed ? element(concat(aws_db_option_group.this.*.id, [""]), 0) : var.option_group_name
  parameter_group_name                  = local.db_parameter_group_needed ? element(concat(aws_db_parameter_group.this.*.id, [""]), 0) : var.parameter_group_name
  password                              = var.master_password
  port                                  = var.port
  publicly_accessible                   = var.publicly_accessible
  replicate_source_db                   = var.db_instance_replicate_source_db
  skip_final_snapshot                   = var.skip_final_snapshot
  snapshot_identifier                   = var.snapshot_identifier
  storage_encrypted                     = true
  storage_type                          = var.db_instance_storage_type
  timezone                              = var.db_instance_timezone
  username                              = var.master_username
  vpc_security_group_ids                = concat(aws_security_group.this.*.id, var.additionnal_security_group)
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_kms_key_id
  performance_insights_retention_period = var.db_instance_performance_insights_retention_period

  dynamic "s3_import" {
    for_each = var.enable_s3_import ? [1] : []

    content {
      source_engine         = var.s3_import_source_engine
      source_engine_version = var.s3_import_source_engine_version
      bucket_name           = var.s3_import_bucket_name
      bucket_prefix         = var.s3_import_bucket_prefix
      ingestion_role        = var.s3_import_ingestion_role
    }
  }

  tags = merge({
    Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.database_identifier, (count.index + 1)) : format("%s%s-%02d", var.prefix, var.database_identifier, count.index + 1)
    },
    length(var.db_instance_tags) > 0 ? var.db_instance_tags[count.index] : {},
    local.tags,
    var.db_instance_global_tags,
    var.tags
  )
}

locals {
  db_parameter_group_needed = ! local.is_aurora && length(var.parameter_group_parameters) > 0
}

resource "aws_db_parameter_group" "this" {
  count = var.enable && local.db_parameter_group_needed ? 1 : 0

  name        = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.parameter_group_name, count.index + 1) : format("%s%s", var.prefix, var.parameter_group_name)
  family      = var.parameter_group_family
  description = local.description

  dynamic "parameter" {
    for_each = var.parameter_group_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = merge(
    var.tags,
    var.parameter_group_tags,
    {
      Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.parameter_group_name, count.index + 1) : format("%s%s", var.prefix, var.parameter_group_name)
    },
    local.tags,
  )
}

locals {
  db_option_group_needed = ! local.is_aurora && length(var.option_group_options) > 0
}

resource "aws_db_option_group" "this" {
  count = var.enable && local.db_option_group_needed ? 1 : 0

  name                     = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.option_group_name, count.index + 1) : format("%s%s", var.prefix, var.option_group_name)
  option_group_description = local.description
  engine_name              = var.option_group_engine_name
  major_engine_version     = var.option_group_major_engine_version

  dynamic "option" {
    for_each = var.option_group_options

    content {
      option_name                    = option.value.option_name
      port                           = lookup(option.value, "port", null)
      version                        = lookup(option.value, "version", null)
      db_security_group_memberships  = lookup(option.value, "db_security_group_memberships", null)
      vpc_security_group_memberships = lookup(option.value, "vpc_security_group_memberships", null)

      dynamic "option_settings" {
        for_each = option.value.option_settings

        content {
          name  = option_settings.value.name
          value = option_settings.value.value
        }
      }
    }
  }

  tags = merge(
    var.tags,
    var.option_group_tags,
    {
      Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.option_group_name, count.index + 1) : format("%s%s", var.prefix, var.option_group_name)
    },
    local.tags,
  )
}


#####
# Security group
#####

locals {
  security_group_needed = length(var.security_group_source_cidrs) > 0 || length(var.security_group_source_security_group) > 0
}

resource "aws_security_group" "this" {
  count = var.enable && local.security_group_needed ? 1 : 0

  name        = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.security_group_name, count.index + 1) : format("%s%s", var.prefix, var.security_group_name)
  description = local.description
  vpc_id      = var.security_group_vpc_id
  tags = merge(
    var.tags,
    var.security_group_tags,
    {
      Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.security_group_name, count.index + 1) : format("%s%s", var.prefix, var.security_group_name)
    },
    local.tags,
  )
}

resource "aws_security_group_rule" "this_in_cidr" {
  count = var.enable && length(var.security_group_source_cidrs) > 0 ? 1 : 0

  type              = "ingress"
  from_port         = element(concat(aws_rds_cluster.this.*.port, aws_db_instance.this.*.port, [0]), 0)
  to_port           = element(concat(aws_rds_cluster.this.*.port, aws_db_instance.this.*.port, [0]), 0)
  protocol          = "tcp"
  cidr_blocks       = var.security_group_source_cidrs
  security_group_id = element(concat(aws_security_group.this.*.id, [""]), 0)
}

resource "aws_security_group_rule" "this_in_sg" {
  count = var.enable && length(var.security_group_source_security_group) > 0 ? length(var.security_group_source_security_group) : 0

  type                     = "ingress"
  from_port                = element(concat(aws_rds_cluster.this.*.port, aws_db_instance.this.*.port, [0]), 0)
  to_port                  = element(concat(aws_rds_cluster.this.*.port, aws_db_instance.this.*.port, [0]), 0)
  protocol                 = "tcp"
  source_security_group_id = var.security_group_source_security_group[count.index]
  security_group_id        = element(concat(aws_security_group.this.*.id, [""]), 0)
}

#####
# SSM
#####

locals {
  ssm_parameters_kms_key_id = var.ssm_parameters_kms_key_create ? null : var.ssm_parameters_use_database_kms_key ? local.kms_key_id : var.ssm_parameters_use_default_kms_key ? null : var.ssm_parameters_kms_key_id
  ssm_parameters_names = concat(
    var.ssm_parameters_export_endpoint ? [var.ssm_parameters_endpoint_key_name] : [],
    var.ssm_parameters_export_port ? [var.ssm_parameters_port_key_name] : [],
    var.ssm_parameters_export_master_username ? [var.ssm_parameters_master_username_key_name] : [],
    var.ssm_parameters_export_master_password ? [var.ssm_parameters_master_password_key_name] : [],
    var.ssm_parameters_export_database_name ? [var.ssm_parameters_database_name_key_name] : [],
    var.ssm_parameters_export_character_set_name ? [var.ssm_parameters_character_set_name_key_name] : [],
    var.ssm_parameters_export_endpoint_reader ? [var.ssm_parameters_endpoint_reader_key_name] : [],
  )
}

module "ssm" {
  source = "git::https://github.com/FXinnovation/fx-terraform-module-aws-ssm-parameters.git?ref=2.0.1"

  enabled = var.enable && var.create_ssm_parameters

  prefix = var.ssm_parameters_prefix

  parameters_count = length(local.ssm_parameters_names)
  names            = local.ssm_parameters_names
  types = concat(
    var.ssm_parameters_export_endpoint ? ["String"] : [],
    var.ssm_parameters_export_port ? ["String"] : [],
    var.ssm_parameters_export_master_username ? ["SecureString"] : [],
    var.ssm_parameters_export_master_password ? ["SecureString"] : [],
    var.ssm_parameters_export_database_name ? ["String"] : [],
    var.ssm_parameters_export_character_set_name ? ["String"] : [],
    var.ssm_parameters_export_endpoint_reader ? ["String"] : [],
  )
  values = concat(
    var.ssm_parameters_export_endpoint ? [element(concat(aws_rds_cluster.this.*.endpoint, aws_db_instance.this.*.address, ["N/A"]), 0)] : [],
    var.ssm_parameters_export_port ? [element(concat(aws_rds_cluster.this.*.port, aws_db_instance.this.*.port, ["N/A"]), 0)] : [],
    var.ssm_parameters_export_master_username ? [element(concat(aws_rds_cluster.this.*.master_username, aws_db_instance.this.*.username, ["N/A"]), 0)] : [],
    var.ssm_parameters_export_master_password ? [var.master_password] : [],
    var.ssm_parameters_export_database_name ? [var.database_name != null ? var.database_name : "N/A"] : [],
    var.ssm_parameters_export_character_set_name ? [var.db_instance_character_set_name != null ? var.db_instance_character_set_name : "N/A"] : [],
    var.ssm_parameters_export_endpoint_reader ? [element(concat(aws_rds_cluster.this.*.reader_endpoint, ["N/A"]), 0)] : [],
  )
  descriptions = concat(
    var.ssm_parameters_export_endpoint ? [var.ssm_parameters_endpoint_description] : [],
    var.ssm_parameters_export_port ? [var.ssm_parameters_port_description] : [],
    var.ssm_parameters_export_master_username ? [var.ssm_parameters_master_username_description] : [],
    var.ssm_parameters_export_master_password ? [var.ssm_parameters_master_password_description] : [],
    var.ssm_parameters_export_database_name ? [var.ssm_parameters_database_name_description] : [],
    var.ssm_parameters_export_character_set_name ? [var.ssm_parameters_character_set_name_description] : [],
    var.ssm_parameters_export_endpoint_reader ? [var.ssm_parameters_endpoint_reader_description] : [],
  )

  overwrite = true

  use_default_kms_key = var.ssm_parameters_use_default_kms_key
  kms_key_arn         = local.ssm_parameters_kms_key_id
  kms_key_create      = var.ssm_parameters_kms_key_create
  kms_key_name        = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.ssm_parameters_kms_key_name, 1) : format("%s%s", var.prefix, var.ssm_parameters_kms_key_name)
  kms_key_alias_name  = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.ssm_parameters_kms_key_alias_name, 1) : format("%s%s", var.prefix, var.ssm_parameters_kms_key_alias_name)

  iam_policy_create                 = var.ssm_parameters_iam_policy_create
  iam_policy_path                   = var.ssm_parameters_iam_policy_path
  iam_policy_name_prefix_read_only  = format("%s%s", var.prefix, var.ssm_parameters_iam_policy_name_prefix_read_only)
  iam_policy_name_prefix_read_write = format("%s%s", var.prefix, var.ssm_parameters_iam_policy_name_prefix_read_write)

  kms_tags = merge(
    var.tags,
    var.ssm_parameters_kms_key_tags,
    local.tags,
  )

  tags = merge(
    var.tags,
    var.ssm_parameters_tags,
    local.tags,
  )
}
