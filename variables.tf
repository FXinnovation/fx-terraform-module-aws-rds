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

variable "final_snapshot_identifier_prefix" {
  description = "The prefix name of your final DB snapshot when this DB cluster is deleted. This will be suffixed by a 5 digits random id managed by terraform."
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
  description = "The number of days to retain backups for. Default 1"
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

variable "snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB cluster is deleted."
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled."
  type        = bool
  default     = false
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
  description = "The daily time range during which automated backups are created if automated backups are enabled. Time in UTC, e.g. 04:00-09:00"
  type        = string
  default     = null
}

variable "preferred_maintenance_window" {
  description = "The weekly window to perform maintenance in. Time in UTC  e.g. wed:04:00-wed:04:30"
  type        = string
  default     = null
}

variable "prefix" {
  description = "Prefix to be added to all resources."
  type        = string
  default     = ""
}

variable "description" {
  description = "Description to be added on security_group, rds_parameter_group, kms_key and db_subnet_group."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to be merged with all resources of this module."
  type        = map(string)
  default     = {}
}

variable "cloudwatch_logs_exports" {
  description = "List of log types to export to cloudwatch."
  type        = list(string)
  default     = []
}

variable "enable_s3_import" {
  description = "Enable S3 import"
  type        = bool
  default     = false
}

variable "s3_import_bucket_name" {
  description = "The bucket name where your backup is stored."
  type        = string
  default     = null
}

variable "s3_import_bucket_prefix" {
  description = "Can be blank, but is the path to your backup"
  type        = string
  default     = null
}

variable "s3_import_ingestion_role" {
  description = "Role applied to load the data."
  type        = string
  default     = null
}

variable "s3_import_source_engine" {
  description = "Source engine for the backup "
  type        = string
  default     = null
}

variable "s3_import_source_engine_version" {
  description = "Version of source engine for the backup "
  type        = string
  default     = null
}

variable "db_instance_promotion_tiers" {
  description = "List of number for failover Priority setting on instance level. This will be use for the master election, and, load balancing into the cluster."
  type        = list(number)
  default     = null
}

variable "ca_cert_identifier" {
  description = "he daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC"
  type        = string
  default     = null
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance."
  type        = number
  default     = null
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights is enabled or not."
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data."
  type        = string
  default     = null
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible."
  type        = bool
  default     = false
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

#####
# RDS instance
#####

variable "rds_instance_instance_classes" {
  description = "List of instance classes to use."
  type        = list(string)
  default     = []
}

variable "rds_instance_availability_zones" {
  description = "List of the EC2 Availability Zone that each DB instance are created in."
  type        = list(string)
  default     = []
}

variable "rds_instance_promotion_tiers" {
  description = "List of number for failover Priority setting on instance level"
  type        = list(number)
  default     = null
}

#####
# DB instance
#####

variable "db_instance_instance_class" {
  description = "Instance classes to use."
  type        = string
  default     = null
}

variable "db_instance_availability_zone" {
  description = "Availability zone for the instance. "
  type        = string
  default     = null
}

variable "db_instance_allocated_storage" {
  description = "The allocated storage in gibibytes."
  type        = number
  default     = null
}

variable "db_instance_allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed."
  type        = bool
  default     = false
}

variable "db_instance_character_set_name" {
  description = "The character set name to use for DB encoding in Oracle instances."
  type        = string
  default     = null
}

variable "db_instance_delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted."
  type        = bool
  default     = true
}

variable "db_instance_domain" {
  description = "The ID of the Directory Service Active Directory domain to create the instance in."
  type        = string
  default     = null
}

variable "db_instance_domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service."
  type        = string
  default     = null
}

variable "db_instance_iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of \"io1\"."
  type        = number
  default     = null
}

variable "db_instance_license_model" {
  description = "License model information for this DB instance."
  type        = string
  default     = null
}

variable "db_instance_max_allocated_storage" {
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance."
  type        = number
  default     = null
}

variable "db_instance_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "db_instance_storage_type" {
  description = "One of \"standard\" (magnetic), \"gp2\" (general purpose SSD), or \"io1\" (provisioned IOPS SSD)."
  type        = string
  default     = null
}

variable "db_instance_timezone" {
  description = "Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server."
  type        = string
  default     = null
}

variable "db_instance_performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data"
  type        = number
  default     = null
}

variable "db_instance_replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database."
  type        = string
  default     = null
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

variable "rds_cluster_enable_http_endpoint" {
  description = "Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless."
  type        = bool
  default     = false
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

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted."
  type        = bool
  default     = true
}

variable "rds_cluster_global_cluster_identifier" {
  description = "The global cluster identifier."
  type        = string
  default     = null
}

variable "rds_cluster_iam_roles" {
  description = "A List of ARNs for the IAM roles to associate to the RDS Cluster."
  type        = list(string)
  default     = []
}

variable "rds_cluster_source_region" {
  description = "The source region for an encrypted replica DB."
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
# DB parameter group
#####

variable "parameter_group_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = null
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group."
  type        = string
  default     = null
}

variable "parameter_group_parameters" {
  description = "List of map of parameter to add. apply_method can be immediate or pending-reboot."
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))
  default = []
}

variable "parameter_group_tags" {
  description = "Tags to be added with parameter group"
  type        = map(string)
  default     = {}
}

#####
# DB option group
#####

variable "option_group_name" {
  description = "The name of the option group."
  type        = string
  default     = null
}

variable "option_group_engine_name" {
  description = "Specifies the name of the engine that this option group should be associated with."
  type        = string
  default     = null
}

variable "option_group_major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with. "
  type        = string
  default     = null
}

<<<<<<< HEAD
variable "option_group_options" {
  description = <<-DOCUMENTATION
A list of map of Options to apply. Map must support the following structure:
  * option_name (required, string): The Name of the Option (e.g. MEMCACHED).
  * port (optional, number): The Port number when connecting to the Option (e.g. 11211).
  * version (optional, string): The version of the option (e.g. 13.1.0.0).
  * db_security_group_memberships (optional, string): A list of DB Security Groups for which the option is enabled.
  * vpc_security_group_memberships (optional, string): A list of VPC Security Groups for which the option is enabled.
  * option_settings (required, list of map): A list of map of option settings to apply:
    * name (required, string): The Name of the setting.
    * value (required, string): The Value of the setting.

For example, see folder examples/db_instance_with_option_group.
DOCUMENTATION
  type        = any
  default     = []
}

=======
variable "option_group_option_names" {
  description = "List of option name, e.g. MEMCACHED"
  type        = list(string)
  default     = []
}

variable "option_group_option_ports" {
  description = "List of port use when connecting to the option"
  type        = list(number)
  default     = []
}

variable "option_group_option_versions" {
  description = "List of option version e.g 1.3.1.0.0"
  type        = list(string)
  default     = []
}

variable "option_group_option_db_security_group_memberships" {
  description = "List of list of DB Security Groups for which the option is enabled."
  type        = list(list(string))
  default     = [[]]
}

variable "option_group_option_vpc_security_group_memberships" {
  description = "List of list of VPC Security Groups for which the option is enabled."
  type        = list(list(string))
  default     = [[]]
}

variable "option_group_option_settings" {
  description = "list of list of maps of option settings"
  type = list(list(object({
    name  = string,
    value = string,
  })))
  default = [[]]
}

variable "option_group_tags" {
  description = "Tags to be merge with the DB option group resource."
  type        = map(string)
  default     = {}
}

#####
# KMS key
#####

variable "use_default_kms_key" {
  description = "Use the default KMS key to encrypt DBs."
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
  description = "Name of the KMS if kms_key_create is set to true."
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

variable "security_group_vpc_id" {
  description = "ID of the VPC"
  type        = string
  default     = null
}

variable "security_group_tags" {
  description = "Tags to be merged to the security group"
  type        = map(string)
  default     = {}
}
