output "resource_id" {
  value = module.rds_cluster.resource_id
}

output "endpoint" {
  value = module.rds_cluster.endpoint
}

output "engine" {
  value = module.rds_cluster.engine
}

output "engine_version" {
  value = module.rds_cluster.engine_version
}

output "database_name" {
  value = module.rds_cluster.database_name
}

output "port" {
  value = module.rds_cluster.port
}

output "master_username" {
  value = module.rds_cluster.master_username
}

output "backup_retention_period" {
  value = module.rds_cluster.backup_retention_period
}

output "preferred_backup_window" {
  value = module.rds_cluster.preferred_backup_window
}

output "maintenance_window" {
  value = module.rds_cluster.maintenance_window
}

output "hosted_zone_id" {
  value = module.rds_cluster.hosted_zone_id
}

output "instance_arns" {
  value = module.rds_cluster.instance_arns
}

output "instance_ids" {
  value = module.rds_cluster.instance_ids
}

output "availability_zones" {
  value = module.rds_cluster.availability_zones
}

output "rds_cluster_arn" {
  value = module.rds_cluster.rds_cluster_arn
}

output "rds_cluster_id" {
  value = module.rds_cluster.rds_cluster_id
}

output "rds_cluster_cluster_identifier" {
  value = module.rds_cluster.rds_cluster_cluster_identifier
}

output "rds_cluster_cluster_members" {
  value = module.rds_cluster.rds_cluster_cluster_members
}

output "rds_cluster_availability_zones" {
  value = module.rds_cluster.rds_cluster_availability_zones
}

output "rds_cluster_reader_endpoint" {
  value = module.rds_cluster.rds_cluster_reader_endpoint
}

output "rds_cluster_storage_encrypted" {
  value = module.rds_cluster.rds_cluster_storage_encrypted
}

output "rds_cluster_replication_source_identifier" {
  value = module.rds_cluster.rds_cluster_replication_source_identifier
}

output "rds_cluster_instance_cluster_identifiers" {
  value = module.rds_cluster.rds_cluster_instance_cluster_identifiers
}

output "rds_cluster_instance_identifiers" {
  value = module.rds_cluster.rds_cluster_instance_identifiers
}

output "rds_cluster_instance_writers" {
  value = module.rds_cluster.rds_cluster_instance_writers
}

output "rds_cluster_instance_endpoints" {
  value = module.rds_cluster.rds_cluster_instance_endpoints
}

output "rds_cluster_instance_engines" {
  value = module.rds_cluster.rds_cluster_instance_engines
}

output "rds_cluster_instance_engine_versions" {
  value = module.rds_cluster.rds_cluster_instance_engine_versions
}

output "rds_cluster_instance_ports" {
  value = module.rds_cluster.rds_cluster_instance_ports
}

output "rds_cluster_instance_storage_encrypteds" {
  value = module.rds_cluster.rds_cluster_instance_storage_encrypteds
}

output "rds_cluster_instance_kms_key_ids" {
  value = module.rds_cluster.rds_cluster_instance_kms_key_ids
}

output "rds_cluster_instance_dbi_resource_ids" {
  value = module.rds_cluster.rds_cluster_instance_dbi_resource_ids
}

output "rds_cluster_instance_performance_insights_enableds" {
  value = module.rds_cluster.rds_cluster_instance_performance_insights_enableds
}

output "rds_cluster_instance_performance_insights_kms_key_ids" {
  value = module.rds_cluster.rds_cluster_instance_performance_insights_kms_key_ids
}

output "db_instance_allocated_storage" {
  value = module.rds_cluster.db_instance_allocated_storage
}

output "db_instance_domain" {
  value = module.rds_cluster.db_instance_domain
}

output "db_instance_domain_iam_role_name" {
  value = module.rds_cluster.db_instance_domain_iam_role_name
}

output "db_instance_multi_az" {
  value = module.rds_cluster.db_instance_multi_az
}

output "db_instance_character_set_name" {
  value = module.rds_cluster.db_instance_character_set_name
}

output "parameter_group_id" {
  value = module.rds_cluster.parameter_group_id
}

output "parameter_group_arn" {
  value = module.rds_cluster.parameter_group_arn
}

output "db_subnet_group_id" {
  value = module.rds_cluster.db_subnet_group_id
}

output "db_subnet_group_arn" {
  value = module.rds_cluster.db_subnet_group_arn
}

output "option_group_id" {
  value = module.rds_cluster.option_group_id
}

output "option_group_arn" {
  value = module.rds_cluster.option_group_arn
}

output "kms_key_id" {
  value = module.rds_cluster.kms_key_id
}

output "kms_key_arn" {
  value = module.rds_cluster.kms_key_arn
}

output "kms_key_alias_arn" {
  value = module.rds_cluster.kms_key_alias_arn
}

output "kms_key_alias_target_key_arn" {
  value = module.rds_cluster.kms_key_alias_target_key_arn
}

output "security_group_id" {
  value = module.rds_cluster.security_group_id
}

output "security_group_arn" {
  value = module.rds_cluster.security_group_arn
}

output "security_group_vpc_id" {
  value = module.rds_cluster.security_group_vpc_id
}

output "security_group_owner_id" {
  value = module.rds_cluster.security_group_owner_id
}

output "security_group_name" {
  value = module.rds_cluster.security_group_name
}

output "security_group_description" {
  value = module.rds_cluster.security_group_description
}

output "security_group_ingress" {
  value = module.rds_cluster.security_group_ingress
}

output "security_group_egress" {
  value = module.rds_cluster.security_group_egress
}
