output "resource_id" {
  value = element(concat(aws_rds_cluster.this.*.cluster_resource_id, aws_db_instance.this.*.resource_id, [""]), 0)
}

output "endpoint" {
  value = element(concat(aws_rds_cluster.this.*.endpoint, aws_db_instance.this.*.address, [""]), 0)
}

output "engine" {
  value = element(concat(aws_rds_cluster.this.*.engine, aws_db_instance.this.*.engine, [""]), 0)
}

output "engine_version" {
  value = element(concat(aws_rds_cluster.this.*.engine_version, aws_db_instance.this.*.engine_version, [""]), 0)
}

output "database_name" {
  value = element(concat(aws_rds_cluster.this.*.database_name, aws_db_instance.this.*.name, [""]), 0)
}

output "port" {
  value = element(concat(aws_rds_cluster.this.*.port, aws_db_instance.this.*.port, [""]), 0)
}

output "master_username" {
  value = element(concat(aws_rds_cluster.this.*.master_username, aws_db_instance.this.*.username, [""]), 0)
}

output "backup_retention_period" {
  value = element(concat(aws_rds_cluster.this.*.backup_retention_period, aws_db_instance.this.*.backup_retention_period, [""]), 0)
}

output "preferred_backup_window" {
  value = element(concat(aws_rds_cluster.this.*.preferred_backup_window, aws_db_instance.this.*.backup_window, [""]), 0)
}

output "maintenance_window" {
  value = element(concat(aws_rds_cluster.this.*.preferred_maintenance_window, aws_db_instance.this.*.maintenance_window, [""]), 0)
}

output "hosted_zone_id" {
  value = element(concat(aws_rds_cluster.this.*.hosted_zone_id, aws_db_instance.this.*.hosted_zone_id, [""]), 0)
}

output "instance_arns" {
  value = concat(aws_rds_cluster_instance.this.*.arn, aws_db_instance.this.*.arn)
}

output "instance_ids" {
  value = concat(aws_rds_cluster_instance.this.*.id, aws_db_instance.this.*.id)
}

output "availability_zones" {
  value = concat(aws_rds_cluster_instance.this.*.availability_zone, aws_db_instance.this.*.availability_zone)
}

output "rds_cluster_arn" {
  value = element(concat(aws_rds_cluster.this.*.arn, [""]), 0)
}

output "rds_cluster_id" {
  value = element(concat(aws_rds_cluster.this.*.id, [""]), 0)
}

output "rds_cluster_cluster_identifier" {
  value = element(concat(aws_rds_cluster.this.*.cluster_identifier, [""]), 0)
}

output "rds_cluster_cluster_members" {
  value = element(concat(aws_rds_cluster.this.*.cluster_members, [""]), 0)
}

output "rds_cluster_availability_zones" {
  value = element(concat(aws_rds_cluster.this.*.availability_zones, [""]), 0)
}

output "rds_cluster_reader_endpoint" {
  value = element(concat(aws_rds_cluster.this.*.reader_endpoint, [""]), 0)
}

output "rds_cluster_storage_encrypted" {
  value = element(concat(aws_rds_cluster.this.*.storage_encrypted, [""]), 0)
}

output "rds_cluster_replication_source_identifier" {
  value = element(concat(aws_rds_cluster.this.*.replication_source_identifier, [""]), 0)
}

output "rds_cluster_instance_cluster_identifiers" {
  value = aws_rds_cluster_instance.this.*.cluster_identifier
}

output "rds_cluster_instance_identifiers" {
  value = aws_rds_cluster_instance.this.*.identifier
}

output "rds_cluster_instance_writers" {
  value = aws_rds_cluster_instance.this.*.writer
}

output "rds_cluster_instance_endpoints" {
  value = aws_rds_cluster_instance.this.*.endpoint
}

output "rds_cluster_instance_engines" {
  value = aws_rds_cluster_instance.this.*.engine
}

output "rds_cluster_instance_engine_versions" {
  value = aws_rds_cluster_instance.this.*.engine_version
}

output "rds_cluster_instance_ports" {
  value = aws_rds_cluster_instance.this.*.port
}

output "rds_cluster_instance_storage_encrypteds" {
  value = aws_rds_cluster_instance.this.*.storage_encrypted
}

output "rds_cluster_instance_kms_key_ids" {
  value = aws_rds_cluster_instance.this.*.kms_key_id
}

output "rds_cluster_instance_dbi_resource_ids" {
  value = aws_rds_cluster_instance.this.*.dbi_resource_id
}

output "rds_cluster_instance_performance_insights_enableds" {
  value = aws_rds_cluster_instance.this.*.performance_insights_enabled
}

output "rds_cluster_instance_performance_insights_kms_key_ids" {
  value = aws_rds_cluster_instance.this.*.performance_insights_kms_key_id
}

output "db_instance_allocated_storage" {
  value = element(concat(aws_db_instance.this.*.allocated_storage, [""]), 0)
}

output "db_instance_domain" {
  value = element(concat(aws_db_instance.this.*.domain, [""]), 0)
}

output "db_instance_domain_iam_role_name" {
  value = element(concat(aws_db_instance.this.*.domain_iam_role_name, [""]), 0)
}

output "db_instance_multi_az" {
  value = element(concat(aws_db_instance.this.*.multi_az, [""]), 0)
}

output "db_instance_character_set_name" {
  value = element(concat(aws_db_instance.this.*.character_set_name, [""]), 0)
}

output "parameter_group_id" {
  value = element(concat(aws_rds_cluster_parameter_group.this.*.id, aws_db_parameter_group.this.*.id, [""]), 0)
}

output "parameter_group_arn" {
  value = element(concat(aws_rds_cluster_parameter_group.this.*.arn, aws_db_parameter_group.this.*.arn, [""]), 0)
}

output "db_subnet_group_id" {
  value = element(concat(aws_db_subnet_group.this.*.id, [""]), 0)
}

output "db_subnet_group_arn" {
  value = element(concat(aws_db_subnet_group.this.*.arn, [""]), 0)
}

output "option_group_id" {
  value = element(concat(aws_db_option_group.this.*.id, [""]), 0)
}

output "option_group_arn" {
  value = element(concat(aws_db_option_group.this.*.arn, [""]), 0)
}

output "kms_key_id" {
  value = element(concat(aws_kms_key.this.*.key_id, [""]), 0)
}

output "kms_key_arn" {
  value = element(concat(aws_kms_key.this.*.arn, [""]), 0)
}

output "kms_key_alias_arn" {
  value = element(concat(aws_kms_alias.this.*.arn, [""]), 0)
}

output "kms_key_alias_target_key_arn" {
  value = element(concat(aws_kms_alias.this.*.target_key_arn, [""]), 0)
}

output "security_group_id" {
  value = element(concat(aws_security_group.this.*.id, [""]), 0)
}

output "security_group_arn" {
  value = element(concat(aws_security_group.this.*.arn, [""]), 0)
}

output "security_group_vpc_id" {
  value = element(concat(aws_security_group.this.*.vpc_id, [""]), 0)
}

output "security_group_owner_id" {
  value = element(concat(aws_security_group.this.*.owner_id, [""]), 0)
}

output "security_group_name" {
  value = element(concat(aws_security_group.this.*.name, [""]), 0)
}

output "security_group_description" {
  value = element(concat(aws_security_group.this.*.description, [""]), 0)
}

output "security_group_ingress" {
  value = element(concat(aws_security_group.this.*.ingress, [""]), 0)
}

output "security_group_egress" {
  value = element(concat(aws_security_group.this.*.egress, [""]), 0)
}
