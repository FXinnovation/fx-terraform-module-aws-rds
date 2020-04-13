locals {
  tags = {
    provider = "terraform"
  }

  description = format("For %s %s", local.is_aurora ? "RDS cluster" : "DB instance", var.database_identifier)

  security_group_needed  = length(var.security_group_source_cidrs) > 0 || length(var.security_group_source_security_group) > 0
  db_subnet_group_needed = length(var.db_subnet_group_subnet_ids) > 0
  is_aurora              = replace(var.engine != null ? var.engine : "", "/^aurora{1}.*$/", "1") == "1" ? true : false

  #####
  # RDS
  #####

  rds_cluster_parameter_group_needed = local.is_aurora && length(var.rds_cluster_parameter_group_parameters) > 0
}

#####
# Common resources
#####

resource "aws_db_subnet_group" "this" {
  count = var.enable && local.db_subnet_group_needed ? 1 : 0

  name        = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.db_subnet_group_name, count.index + 1) : format("%s%s", var.prefix, var.db_subnet_group_name)
  description = local.description
  subnet_ids  = var.db_subnet_group_subnet_ids
  tags = merge({
    Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.db_subnet_group_name, count.index + 1) : format("%s%s", var.prefix, var.db_subnet_group_name)
    },
    local.tags,
    var.db_subnet_group_tags,
    var.tags,
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
    {
      "Name" = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.kms_key_name, count.index + 1) : format("%s%s", var.prefix, var.kms_key_name)
    },
    local.tags,
    var.kms_key_tags,
    var.tags,
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
  db_cluster_parameter_group_name = local.rds_cluster_parameter_group_needed ? element(concat(aws_rds_cluster_parameter_group.this.*.id, [""]), 0) : var.rds_cluster_parameter_group_name

  copy_tags_to_snapshot = var.copy_tags_to_snapshot

  database_name          = var.database_name
  master_username        = var.master_username
  master_password        = var.master_password
  port                   = var.port
  vpc_security_group_ids = concat(aws_security_group.this.*.id, var.additionnal_security_group)

  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = var.rds_cluster_skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  snapshot_identifier = var.rds_cluster_snapshot_identifier

  backtrack_window             = var.backtrack_window
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  apply_immediately            = var.apply_immediately


  global_cluster_identifier     = var.rds_cluster_global_cluster_identifier
  replication_source_identifier = var.rds_cluster_replication_source_identifier


  storage_encrypted = true
  kms_key_id        = var.kms_key_create ? element(concat(aws_kms_key.this.*.arn, [""]), 0) : var.use_default_kms_key ? var.kms_key_id : null

  iam_roles                           = var.rds_cluster_iam_roles
  iam_database_authentication_enabled = var.rds_cluster_iam_database_authentication_enabled

  engine                          = var.engine
  engine_mode                     = var.engine_mode
  engine_version                  = var.engine_version
  enabled_cloudwatch_logs_exports = var.rds_cluster_enabled_cloudwatch_logs_exports

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
    for_each = var.rds_cluster_enable_s3_import ? [1] : []

    content {
      source_engine         = var.rds_cluster_s3_import_source_engine
      source_engine_version = var.rds_cluster_s3_import_source_engine_version
      bucket_name           = var.rds_cluster_s3_import_bucket_name
      bucket_prefix         = var.rds_cluster_s3_import_bucket_prefix
      ingestion_role        = var.rds_cluster_s3_import_ingestion_role
    }
  }

  enable_http_endpoint = var.rds_cluster_enable_http_endpoint

  tags = merge({
    Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.rds_cluster_identifier, count.index + 1) : format("%s%s", var.prefix, var.rds_cluster_identifier)
    },
    local.tags,
    var.rds_cluster_tags,
    var.tags,
  )
}


resource "aws_rds_cluster_instance" "this" {
  count = var.enable && local.is_aurora ? length(var.db_instance_instance_classes) : 0

  identifier                      = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.database_identifier, (count.index + 1)) : format("%s%s-%02d", var.prefix, var.database_identifier, count.index + 1)
  cluster_identifier              = element(concat(aws_rds_cluster.this.*.id, [""]), 0)
  engine                          = var.engine
  engine_version                  = var.engine_version
  instance_class                  = var.db_instance_instance_classes[count.index]
  publicly_accessible             = var.db_instance_publicly_accessible
  db_subnet_group_name            = local.db_subnet_group_needed ? element(concat(aws_db_subnet_group.this.*.name, [""]), 0) : var.db_subnet_group_name
  apply_immediately               = var.apply_immediately
  monitoring_role_arn             = var.db_instance_monitoring_role_arn
  monitoring_interval             = var.db_instance_monitoring_interval
  promotion_tier                  = var.db_instance_promotion_tiers != null ? var.db_instance_promotion_tiers[count.index] : null
  availability_zone               = var.db_instance_availability_zones[count.index]
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  performance_insights_enabled    = var.db_instance_performance_insights_enabled
  performance_insights_kms_key_id = var.db_instance_performance_insights_kms_key_id
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  ca_cert_identifier              = var.db_instance_ca_cert_identifier
  tags = merge({
    Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.database_identifier, (count.index + 1)) : format("%s%s", var.prefix, var.database_identifier)
    },
    length(var.db_instance_tags) > 0 ? var.db_instance_tags[count.index] : {},
    local.tags,
    var.db_instance_global_tags,
    var.tags,
  )
}


resource "aws_rds_cluster_parameter_group" "this" {
  count = var.enable && local.rds_cluster_parameter_group_needed ? 1 : 0

  name        = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.rds_cluster_parameter_group_name, count.index + 1) : format("%s%s", var.prefix, var.rds_cluster_parameter_group_name)
  family      = var.rds_cluster_parameter_group_family
  description = local.description

  dynamic "parameter" {
    for_each = var.rds_cluster_parameter_group_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = merge({
    Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.rds_cluster_parameter_group_name, count.index + 1) : format("%s%s", var.prefix, var.rds_cluster_parameter_group_name)
    },
    local.tags,
    var.rds_cluster_parameter_group_tags,
    var.tags
  )
}

#####
# Security group
#####

resource "aws_security_group" "this" {
  count = var.enable && local.security_group_needed ? 1 : 0

  name        = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.security_group_name, count.index + 1) : format("%s%s", var.prefix, var.security_group_name)
  description = local.description
  vpc_id      = var.security_group_vpc_id
  tags = merge({
    Name = var.use_num_suffix ? format("%s%s-%0${var.num_suffix_digits}d", var.prefix, var.security_group_name, count.index + 1) : format("%s%s", var.prefix, var.security_group_name)
    },
    local.tags,
    var.secuirty_group_tags,
    var.tags,
  )
}

resource "aws_security_group_rule" "this_in_cidr" {
  count = var.enable && length(var.security_group_source_cidrs) > 0 ? 1 : 0

  type              = "ingress"
  from_port         = element(concat(aws_rds_cluster.this.*.port, [0]), 0)
  to_port           = element(concat(aws_rds_cluster.this.*.port, [0]), 0)
  protocol          = "tcp"
  cidr_blocks       = var.security_group_source_cidrs
  security_group_id = element(concat(aws_security_group.this.*.id, [""]), 0)
}

resource "aws_security_group_rule" "this_in_sg" {
  count = var.enable && length(var.security_group_source_security_group) > 0 ? length(var.security_group_source_security_group) : 0

  type                     = "ingress"
  from_port                = element(concat(aws_rds_cluster.this.*.port, [0]), 0)
  to_port                  = element(concat(aws_rds_cluster.this.*.port, [0]), 0)
  protocol                 = "tcp"
  source_security_group_id = var.security_group_source_security_group[count.index]
  security_group_id        = element(concat(aws_security_group.this.*.id, [""]), 0)
}
