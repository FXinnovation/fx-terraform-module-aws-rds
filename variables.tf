#####
# Common
#####

variable "enable" {
  description = "Enable this module."
  type        = bool
  default     = true
}

variable "engine" {
  description = "The name of the database engine to be used for this DB"
  type        = string
  default     = null
}

variable "engine_mode" {
  description = "The database engine mode."
  type        = string
  default     = null
}

variable "engine_version" {
  description = "The database engine version."
  type        = string
  default     = null
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB cluster is deleted."
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled."
  type        = bool
  default     = false
}

variable "additionnal_security_group" {
  description = "Additionnal security group to add to db."
  type        = list(string)
  default     = []
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window."
  type        = bool
  default     = true
}

variable "backtrack_window" {
  description = "The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0"
  type        = number
  default     = 0
}

variable "backup_retention_period" {
  description = "The days to retain backups for. Default 1"
  type        = number
  default     = 1
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Cluster tags to snapshots. Default is false."
  type        = bool
  default     = false
}

variable "database_identifier" {
  description = "The database identifier"
  type        = string
  default     = ""
}

variable "database_name" {
  description = "Name for an automatically created database on cluster creation."
  type        = string
  default     = null
}

variable "master_password" {
  description = "Password for the master DB user."
  type        = string
  default     = null
}

variable "master_username" {
  description = "Username for the master DB user."
  type        = string
  default     = null
}

variable "use_num_suffix" {
  description = "Always append numerical suffix to all resources."
  default     = true
}

variable "num_suffix_digits" {
  description = "Number of significant digits to append to instances name."
  type        = number
  default     = 2
}

variable "port" {
  description = "The database port"
  type        = number
  default     = null
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created if automated backups are enabled."
  type        = string
  default     = null
}

variable "preferred_maintenance_window" {
  description = "The window to perform maintenance in."
  type        = string
  default     = null
}

variable "prefix" {
  description = "Prefix to be added to all resources"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to be merged with all resources of this module"
  type        = map(string)
  default     = {}
}

#####
# DB instance
#####

variable "db_instance_ca_cert_identifier" {
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC"
  type        = string
  default     = null
}

variable "db_instance_availability_zones" {
  description = "List of the EC2 Availability Zone that each DB instance are created in."
  type        = list(string)
  default     = []
}

variable "db_instance_instance_classes" {
  description = "List of instance classes to use."
  type        = list(string)
  default     = []
}

variable "db_instance_promotion_tiers" {
  description = "List of number for failover Priority setting on instance level"
  type        = list(number)
  default     = null
}

variable "db_instance_tags" {
  description = "List of Tags to be merge to each db instances"
  type        = list(map(string))
  default     = []
}

variable "db_instance_global_tags" {
  description = "Tags to be merge to all db instances"
  type        = map(string)
  default     = {}
}

variable "db_instance_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance."
  type        = number
  default     = null
}

variable "db_instance_monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  type        = string
  default     = null
}

variable "db_instance_performance_insights_enabled" {
  description = "Specifies whether Performance Insights is enabled or not."
  type        = bool
  default     = false
}

variable "db_instance_performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data."
  type        = string
  default     = null
}

variable "db_instance_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible."
  type        = bool
  default     = false
}

#####
# RDS cluster
#####

variable "rds_cluster_identifier" {
  description = "The global cluster identifier."
  type        = string
  default     = ""
}


variable "rds_cluster_enable_s3_import" {
  description = "Enable S3 import on RDS database creation"
  type        = bool
  default     = false
}

variable "rds_cluster_enable_scaling_configuration" {
  description = "Enable scalling configuration. Only valid when engine_mode is set to serverless."
  type        = bool
  default     = false
}

variable "rds_cluster_iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled."
  type        = bool
  default     = false
}

variable "rds_cluster_iam_roles" {
  description = "A List of ARNs for the IAM roles to associate to the RDS Cluster."
  type        = list(string)
  default     = []
}

variable "rds_cluster_enable_http_endpoint" {
  description = "Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless."
  type        = bool
  default     = false
}

variable "rds_cluster_enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to cloudwatch."
  type        = list(string)
  default     = []
}

variable "rds_cluster_s3_import_bucket_name" {
  description = "The bucket name where your backup is stored."
  type        = string
  default     = null
}

variable "rds_cluster_s3_import_bucket_prefix" {
  description = "Can be blank, but is the path to your backup"
  type        = string
  default     = null
}

variable "rds_cluster_s3_import_ingestion_role" {
  description = "Role applied to load the data."
  type        = string
  default     = null
}

variable "rds_cluster_s3_import_source_engine" {
  description = "Source engine for the backup "
  type        = string
  default     = null
}

variable "rds_cluster_s3_import_source_engine_version" {
  description = "Version of the source engine used to make the backup"
  type        = string
  default     = null
}

variable "rds_cluster_scaling_configuration_auto_pause" {
  description = "Whether to enable automatic pause. A DB cluster can be paused only when it's idle (it has no connections)."
  type        = string
  default     = null
}

variable "rds_cluster_scaling_configuration_max_capacity" {
  description = "The maximum capacity."
  type        = number
  default     = null
}

variable "rds_cluster_scaling_configuration_min_capacity" {
  description = "The minimum capacity."
  type        = number
  default     = null
}

variable "rds_cluster_scaling_configuration_seconds_until_auto_pause" {
  description = "The time, in seconds, before an Aurora DB cluster in serverless mode is paused."
  type        = number
  default     = null
}

variable "rds_cluster_scaling_configuration_timeout_action" {
  description = "The action to take when the timeout is reached."
  type        = string
  default     = null
}

variable "rds_cluster_replication_source_identifier" {
  description = "ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica."
  type        = string
  default     = null
}

variable "rds_cluster_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted."
  type        = bool
  default     = true
}

variable "rds_cluster_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB cluster is deleted."
  type        = string
  default     = null
}

variable "rds_cluster_source_region" {
  description = "The source region for an encrypted replica DB cluster."
  type        = string
  default     = null
}

variable "rds_cluster_global_cluster_identifier" {
  description = "The global cluster identifier."
  type        = string
  default     = null
}

variable "rds_cluster_tags" {
  description = "Tags to be merged to RDS cluster"
  type        = map(string)
  default     = {}
}

#####
# DB subnet
#####

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group."
  type        = string
  default     = null
}

variable "db_subnet_group_tags" {
  description = "Map of tags to be nerge with db subnet group"
  type        = map(string)
  default     = {}
}

variable "db_subnet_group_subnet_ids" {
  description = "A list of VPC subnet IDs."
  type        = list(string)
  default     = []
}

#####
# DB cluster parameter group
#####

variable "rds_cluster_parameter_group_family" {
  description = "The family of the DB cluster parameter group"
  type        = string
  default     = null
}

variable "rds_cluster_parameter_group_name" {
  description = "The name of the DB cluster parameter group."
  type        = string
  default     = null
}

variable "rds_cluster_parameter_group_parameters" {
  description = "List of map of parameter to add."
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))
  default = []
}

variable "rds_cluster_parameter_group_tags" {
  description = "Tags to be added with parameter group"
  type        = map(string)
  default     = {}
}

#####
# KMS key
#####

variable "use_default_kms_key" {
  description = "USe the default KMS key to encrypt DBs."
  type        = bool
  default     = true
}

variable "kms_key_alias_name" {
  description = "Alias of the KMS key"
  type        = string
  default     = null
}

variable "kms_key_create" {
  description = "Create a kms key for database"
  type        = bool
  default     = false
}

variable "kms_key_create_alias" {
  description = "Create a kms key alias for database"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "ID of KMS key used for database encryption."
  type        = string
  default     = null
}

variable "kms_key_name" {
  description = "Name of the KMS"
  type        = string
  default     = null
}

variable "kms_key_policy_json" {
  description = "Policy of the KMS Key"
  type        = string
  default     = null
}

variable "kms_key_tags" {
  description = "Tags to be merged with all KMS key resources"
  type        = map(string)
  default     = {}
}

#####
# Security group
#####

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = ""
}

variable "security_group_source_cidrs" {
  description = "List for CIDR to add as inbound address in the security group."
  type        = list(string)
  default     = []
}

variable "security_group_source_security_group" {
  description = "List of security group id to be add as source security group"
  type        = list(string)
  default     = []
}

variable "secuirty_group_tags" {
  description = "Tags to be merged to security group"
  type        = map(string)
  default     = {}
}

variable "security_group_vpc_id" {
  description = "ID of the VPC"
  type        = string
  default     = null
}
