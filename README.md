# terraform-module-aws-rds

Terraform module that helps you create a RDS instance.

This module can create :
  * 1 RDS cluster with n RDS cluster endpoint OR 1 RDS db instance (dynamiclly choosen depending the engine)
  * 1 option group (if not RDS cluster)
  * 1 parameter group / cluster parameter group (dynamiclly choosen depending the engine)
  * 1 subnet group
  * 1 KMS key
  * 1 security group that allow security groups and/or cidr range to access to the database
  * Export RDS endpoint, RDS reader endpoint, RDS port, master username, master password, database name and character set name on SSM parameters. Master username and master password are stored as SecureString, encrypted by a KMS key.

## Limitations:

 * This module doesn't support RDS global cluster creation. There is an issue with deletion :
   ```
   error deleting RDS Cluster (nsu6suhxtftest-00001): InvalidDBClusterStateFault: This cluster is a part of a global cluster, please remove it from globalcluster first
   ```
  * No KMS key created internally for performance insights. Must be given externally.
  * You can't specify the availability zone for RDS cluster because API has an issue:
    https://github.com/terraform-providers/terraform-provider-aws/issues/1111

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ssm"></a> [ssm](#module\_ssm) | git::https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/terraform-module-aws-ssm-parameters.git | 3.0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_option_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_option_group) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_rds_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.client_egress_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_in_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_in_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_id.final_snapshot](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additionnal_security_group"></a> [additionnal\_security\_group](#input\_additionnal\_security\_group) | Additionnal security group to add to db. | `list(string)` | `[]` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of CIDR's that will be allowed to talk to the database. These should be CIDR's of the "clients" accessing the RDS. | `list(string)` | `[]` | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | List of security group ID's that will be allowed to talk to the database. These should be the security groups of the "clients" accessing the RDS. | `list(string)` | `[]` | no |
| <a name="input_allowed_security_group_ids_count"></a> [allowed\_security\_group\_ids\_count](#input\_allowed\_security\_group\_ids\_count) | Number of security group ID's that are set in the `allowed_security_group_ids` variable. | `number` | `0` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. | `bool` | `true` | no |
| <a name="input_backtrack_window"></a> [backtrack\_window](#input\_backtrack\_window) | The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0 | `number` | `0` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The number of days to retain backups for. Default 1 | `number` | `1` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | he daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC | `string` | `null` | no |
| <a name="input_cloudwatch_logs_exports"></a> [cloudwatch\_logs\_exports](#input\_cloudwatch\_logs\_exports) | List of log types to export to cloudwatch. | `list(string)` | `[]` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Copy all Cluster tags to snapshots. Default is false. | `bool` | `false` | no |
| <a name="input_create_ssm_parameters"></a> [create\_ssm\_parameters](#input\_create\_ssm\_parameters) | Create SMM parameters related to database informations | `bool` | `false` | no |
| <a name="input_database_identifier"></a> [database\_identifier](#input\_database\_identifier) | The database identifier | `string` | `""` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name for an automatically created database on cluster creation. | `string` | `null` | no |
| <a name="input_db_instance_allocated_storage"></a> [db\_instance\_allocated\_storage](#input\_db\_instance\_allocated\_storage) | The allocated storage in gibibytes. | `number` | `null` | no |
| <a name="input_db_instance_allow_major_version_upgrade"></a> [db\_instance\_allow\_major\_version\_upgrade](#input\_db\_instance\_allow\_major\_version\_upgrade) | Indicates that major version upgrades are allowed. | `bool` | `false` | no |
| <a name="input_db_instance_availability_zone"></a> [db\_instance\_availability\_zone](#input\_db\_instance\_availability\_zone) | Availability zone for the instance. | `string` | `null` | no |
| <a name="input_db_instance_character_set_name"></a> [db\_instance\_character\_set\_name](#input\_db\_instance\_character\_set\_name) | The character set name to use for DB encoding in Oracle instances. | `string` | `null` | no |
| <a name="input_db_instance_delete_automated_backups"></a> [db\_instance\_delete\_automated\_backups](#input\_db\_instance\_delete\_automated\_backups) | Specifies whether to remove automated backups immediately after the DB instance is deleted. | `bool` | `true` | no |
| <a name="input_db_instance_domain"></a> [db\_instance\_domain](#input\_db\_instance\_domain) | The ID of the Directory Service Active Directory domain to create the instance in. | `string` | `null` | no |
| <a name="input_db_instance_domain_iam_role_name"></a> [db\_instance\_domain\_iam\_role\_name](#input\_db\_instance\_domain\_iam\_role\_name) | The name of the IAM role to be used when making API calls to the Directory Service. | `string` | `null` | no |
| <a name="input_db_instance_global_tags"></a> [db\_instance\_global\_tags](#input\_db\_instance\_global\_tags) | Tags to be merge to all db instances | `map(string)` | `{}` | no |
| <a name="input_db_instance_instance_class"></a> [db\_instance\_instance\_class](#input\_db\_instance\_instance\_class) | Instance classes to use. | `string` | `null` | no |
| <a name="input_db_instance_iops"></a> [db\_instance\_iops](#input\_db\_instance\_iops) | The amount of provisioned IOPS. Setting this implies a storage\_type of "io1". | `number` | `null` | no |
| <a name="input_db_instance_license_model"></a> [db\_instance\_license\_model](#input\_db\_instance\_license\_model) | License model information for this DB instance. | `string` | `null` | no |
| <a name="input_db_instance_max_allocated_storage"></a> [db\_instance\_max\_allocated\_storage](#input\_db\_instance\_max\_allocated\_storage) | When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. | `number` | `null` | no |
| <a name="input_db_instance_multi_az"></a> [db\_instance\_multi\_az](#input\_db\_instance\_multi\_az) | Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| <a name="input_db_instance_performance_insights_retention_period"></a> [db\_instance\_performance\_insights\_retention\_period](#input\_db\_instance\_performance\_insights\_retention\_period) | The amount of time in days to retain Performance Insights data | `number` | `null` | no |
| <a name="input_db_instance_promotion_tiers"></a> [db\_instance\_promotion\_tiers](#input\_db\_instance\_promotion\_tiers) | List of number for failover Priority setting on instance level. This will be use for the master election, and, load balancing into the cluster. | `list(number)` | `null` | no |
| <a name="input_db_instance_replicate_source_db"></a> [db\_instance\_replicate\_source\_db](#input\_db\_instance\_replicate\_source\_db) | Specifies that this resource is a Replicate database, and to use this value as the source database. | `string` | `null` | no |
| <a name="input_db_instance_storage_type"></a> [db\_instance\_storage\_type](#input\_db\_instance\_storage\_type) | One of "standard" (magnetic), "gp2" (general purpose SSD), or "io1" (provisioned IOPS SSD). | `string` | `null` | no |
| <a name="input_db_instance_tags"></a> [db\_instance\_tags](#input\_db\_instance\_tags) | List of Tags to be merge to each db instances | `list(map(string))` | `[]` | no |
| <a name="input_db_instance_timezone"></a> [db\_instance\_timezone](#input\_db\_instance\_timezone) | Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. | `string` | `null` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | The name of the DB subnet group. | `string` | `null` | no |
| <a name="input_db_subnet_group_subnet_ids"></a> [db\_subnet\_group\_subnet\_ids](#input\_db\_subnet\_group\_subnet\_ids) | A list of VPC subnet IDs. | `list(string)` | `[]` | no |
| <a name="input_db_subnet_group_tags"></a> [db\_subnet\_group\_tags](#input\_db\_subnet\_group\_tags) | Map of tags to be nerge with db subnet group | `map(string)` | `{}` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description to be added on security\_group, rds\_parameter\_group, kms\_key and db\_subnet\_group. | `string` | `null` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Whether or not to enable this module. | `bool` | `true` | no |
| <a name="input_enable_s3_import"></a> [enable\_s3\_import](#input\_enable\_s3\_import) | Enable S3 import | `bool` | `false` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The name of the database engine to be used for this DB | `string` | `null` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | The database engine mode. | `string` | `null` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The database engine version. | `string` | `null` | no |
| <a name="input_final_snapshot_identifier_prefix"></a> [final\_snapshot\_identifier\_prefix](#input\_final\_snapshot\_identifier\_prefix) | The prefix name of your final DB snapshot when this DB cluster is deleted. This will be suffixed by a 5 digits random id managed by terraform. | `string` | `null` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled. | `bool` | `false` | no |
| <a name="input_kms_key_alias_name"></a> [kms\_key\_alias\_name](#input\_kms\_key\_alias\_name) | Alias of the KMS key | `string` | `null` | no |
| <a name="input_kms_key_create"></a> [kms\_key\_create](#input\_kms\_key\_create) | Create a kms key for database | `bool` | `false` | no |
| <a name="input_kms_key_create_alias"></a> [kms\_key\_create\_alias](#input\_kms\_key\_create\_alias) | Create a kms key alias for database | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ID of KMS key used for database encryption. | `string` | `null` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | Name of the KMS if kms\_key\_create is set to true. | `string` | `null` | no |
| <a name="input_kms_key_policy_json"></a> [kms\_key\_policy\_json](#input\_kms\_key\_policy\_json) | Policy of the KMS Key | `string` | `null` | no |
| <a name="input_kms_key_tags"></a> [kms\_key\_tags](#input\_kms\_key\_tags) | Tags to be merged with all KMS key resources | `map(string)` | `{}` | no |
| <a name="input_manage_client_security_group_rules"></a> [manage\_client\_security\_group\_rules](#input\_manage\_client\_security\_group\_rules) | Whether or not to manage the security group rules for the client security group ids (`allowed_security_group_ids`). | `bool` | `true` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | Password for the master DB user. | `string` | `null` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Username for the master DB user. | `string` | `null` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. | `number` | `null` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `string` | `null` | no |
| <a name="input_num_suffix_digits"></a> [num\_suffix\_digits](#input\_num\_suffix\_digits) | Number of significant digits to append to instances name. | `number` | `2` | no |
| <a name="input_option_group_engine_name"></a> [option\_group\_engine\_name](#input\_option\_group\_engine\_name) | Specifies the name of the engine that this option group should be associated with. | `string` | `null` | no |
| <a name="input_option_group_major_engine_version"></a> [option\_group\_major\_engine\_version](#input\_option\_group\_major\_engine\_version) | Specifies the major version of the engine that this option group should be associated with. | `string` | `null` | no |
| <a name="input_option_group_name"></a> [option\_group\_name](#input\_option\_group\_name) | The name of the option group. | `string` | `null` | no |
| <a name="input_option_group_options"></a> [option\_group\_options](#input\_option\_group\_options) | A list of map of Options to apply. Map must support the following structure:<br>  * option\_name (required, string): The Name of the Option (e.g. MEMCACHED).<br>  * port (optional, number): The Port number when connecting to the Option (e.g. 11211).<br>  * version (optional, string): The version of the option (e.g. 13.1.0.0).<br>  * db\_security\_group\_memberships (optional, string): A list of DB Security Groups for which the option is enabled.<br>  * vpc\_security\_group\_memberships (optional, string): A list of VPC Security Groups for which the option is enabled.<br>  * option\_settings (required, list of map): A list of map of option settings to apply:<br>    * name (required, string): The Name of the setting.<br>    * value (required, string): The Value of the setting.<br><br>For example, see folder examples/db\_instance\_with\_option\_group. | `any` | `[]` | no |
| <a name="input_option_group_tags"></a> [option\_group\_tags](#input\_option\_group\_tags) | Tags to be merge with the DB option group resource. | `map(string)` | `{}` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | The family of the DB parameter group | `string` | `null` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | The name of the DB parameter group. | `string` | `null` | no |
| <a name="input_parameter_group_parameters"></a> [parameter\_group\_parameters](#input\_parameter\_group\_parameters) | List of map of parameter to add. apply\_method can be immediate or pending-reboot. | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| <a name="input_parameter_group_tags"></a> [parameter\_group\_tags](#input\_parameter\_group\_tags) | Tags to be added with parameter group | `map(string)` | `{}` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights is enabled or not. | `bool` | `false` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The ARN for the KMS key to encrypt Performance Insights data. | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | The database port | `number` | `null` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | The daily time range during which automated backups are created if automated backups are enabled. Time in UTC, e.g. 04:00-09:00 | `string` | `null` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | The weekly window to perform maintenance in. Time in UTC  e.g. wed:04:00-wed:04:30 | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to be added to all resources, except SSM paramter keys. To prefix SSM parameter keys, see `ssm_parameters_prefix`. | `string` | `""` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Bool to control if instance is publicly accessible. | `bool` | `false` | no |
| <a name="input_rds_cluster_enable_http_endpoint"></a> [rds\_cluster\_enable\_http\_endpoint](#input\_rds\_cluster\_enable\_http\_endpoint) | Enable HTTP endpoint (data API). Only valid when engine\_mode is set to serverless. | `bool` | `false` | no |
| <a name="input_rds_cluster_enable_s3_import"></a> [rds\_cluster\_enable\_s3\_import](#input\_rds\_cluster\_enable\_s3\_import) | Enable S3 import on RDS database creation | `bool` | `false` | no |
| <a name="input_rds_cluster_enable_scaling_configuration"></a> [rds\_cluster\_enable\_scaling\_configuration](#input\_rds\_cluster\_enable\_scaling\_configuration) | Enable scalling configuration. Only valid when engine\_mode is set to serverless. | `bool` | `false` | no |
| <a name="input_rds_cluster_global_cluster_identifier"></a> [rds\_cluster\_global\_cluster\_identifier](#input\_rds\_cluster\_global\_cluster\_identifier) | The global cluster identifier. | `string` | `null` | no |
| <a name="input_rds_cluster_iam_roles"></a> [rds\_cluster\_iam\_roles](#input\_rds\_cluster\_iam\_roles) | A List of ARNs for the IAM roles to associate to the RDS Cluster. | `list(string)` | `[]` | no |
| <a name="input_rds_cluster_identifier"></a> [rds\_cluster\_identifier](#input\_rds\_cluster\_identifier) | The global cluster identifier. | `string` | `""` | no |
| <a name="input_rds_cluster_replication_source_identifier"></a> [rds\_cluster\_replication\_source\_identifier](#input\_rds\_cluster\_replication\_source\_identifier) | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. | `string` | `null` | no |
| <a name="input_rds_cluster_scaling_configuration_auto_pause"></a> [rds\_cluster\_scaling\_configuration\_auto\_pause](#input\_rds\_cluster\_scaling\_configuration\_auto\_pause) | Whether to enable automatic pause. A DB cluster can be paused only when it's idle (it has no connections). | `string` | `null` | no |
| <a name="input_rds_cluster_scaling_configuration_max_capacity"></a> [rds\_cluster\_scaling\_configuration\_max\_capacity](#input\_rds\_cluster\_scaling\_configuration\_max\_capacity) | The maximum capacity. | `number` | `null` | no |
| <a name="input_rds_cluster_scaling_configuration_min_capacity"></a> [rds\_cluster\_scaling\_configuration\_min\_capacity](#input\_rds\_cluster\_scaling\_configuration\_min\_capacity) | The minimum capacity. | `number` | `null` | no |
| <a name="input_rds_cluster_scaling_configuration_seconds_until_auto_pause"></a> [rds\_cluster\_scaling\_configuration\_seconds\_until\_auto\_pause](#input\_rds\_cluster\_scaling\_configuration\_seconds\_until\_auto\_pause) | The time, in seconds, before an Aurora DB cluster in serverless mode is paused. | `number` | `null` | no |
| <a name="input_rds_cluster_scaling_configuration_timeout_action"></a> [rds\_cluster\_scaling\_configuration\_timeout\_action](#input\_rds\_cluster\_scaling\_configuration\_timeout\_action) | The action to take when the timeout is reached. | `string` | `null` | no |
| <a name="input_rds_cluster_source_region"></a> [rds\_cluster\_source\_region](#input\_rds\_cluster\_source\_region) | The source region for an encrypted replica DB. | `string` | `null` | no |
| <a name="input_rds_cluster_tags"></a> [rds\_cluster\_tags](#input\_rds\_cluster\_tags) | Tags to be merged to RDS cluster | `map(string)` | `{}` | no |
| <a name="input_rds_instance_availability_zones"></a> [rds\_instance\_availability\_zones](#input\_rds\_instance\_availability\_zones) | List of the EC2 Availability Zone that each DB instance are created in. | `list(string)` | `[]` | no |
| <a name="input_rds_instance_instance_classes"></a> [rds\_instance\_instance\_classes](#input\_rds\_instance\_instance\_classes) | List of instance classes to use. | `list(string)` | `[]` | no |
| <a name="input_rds_instance_promotion_tiers"></a> [rds\_instance\_promotion\_tiers](#input\_rds\_instance\_promotion\_tiers) | List of number for failover Priority setting on instance level | `list(number)` | `null` | no |
| <a name="input_s3_import_bucket_name"></a> [s3\_import\_bucket\_name](#input\_s3\_import\_bucket\_name) | The bucket name where your backup is stored. | `string` | `null` | no |
| <a name="input_s3_import_bucket_prefix"></a> [s3\_import\_bucket\_prefix](#input\_s3\_import\_bucket\_prefix) | Can be blank, but is the path to your backup | `string` | `null` | no |
| <a name="input_s3_import_ingestion_role"></a> [s3\_import\_ingestion\_role](#input\_s3\_import\_ingestion\_role) | Role applied to load the data. | `string` | `null` | no |
| <a name="input_s3_import_source_engine"></a> [s3\_import\_source\_engine](#input\_s3\_import\_source\_engine) | Source engine for the backup | `string` | `null` | no |
| <a name="input_s3_import_source_engine_version"></a> [s3\_import\_source\_engine\_version](#input\_s3\_import\_source\_engine\_version) | Version of source engine for the backup | `string` | `null` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group | `string` | `""` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | Tags to be merged to the security group | `map(string)` | `{}` | no |
| <a name="input_security_group_vpc_id"></a> [security\_group\_vpc\_id](#input\_security\_group\_vpc\_id) | ID of the VPC | `string` | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB cluster is deleted. | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | The name of your final DB snapshot when this DB cluster is deleted. | `string` | `null` | no |
| <a name="input_ssm_parameters_character_set_name_description"></a> [ssm\_parameters\_character\_set\_name\_description](#input\_ssm\_parameters\_character\_set\_name\_description) | Description of the character set name SSM parameter. | `string` | `"Character set name of the database"` | no |
| <a name="input_ssm_parameters_character_set_name_key_name"></a> [ssm\_parameters\_character\_set\_name\_key\_name](#input\_ssm\_parameters\_character\_set\_name\_key\_name) | Name of the character set name SSM parameter key. | `string` | `"characterSetName"` | no |
| <a name="input_ssm_parameters_database_name_description"></a> [ssm\_parameters\_database\_name\_description](#input\_ssm\_parameters\_database\_name\_description) | Description of the database name SSM parameter. | `string` | `"Database name created by AWS"` | no |
| <a name="input_ssm_parameters_database_name_key_name"></a> [ssm\_parameters\_database\_name\_key\_name](#input\_ssm\_parameters\_database\_name\_key\_name) | Name of the database name SSM parameter key. | `string` | `"databaseName"` | no |
| <a name="input_ssm_parameters_endpoint_description"></a> [ssm\_parameters\_endpoint\_description](#input\_ssm\_parameters\_endpoint\_description) | Description of the endpoint SSM parameter. | `string` | `"DNS address of the database"` | no |
| <a name="input_ssm_parameters_endpoint_key_name"></a> [ssm\_parameters\_endpoint\_key\_name](#input\_ssm\_parameters\_endpoint\_key\_name) | Name of the endpoint SSM parameter key. | `string` | `"endpoint"` | no |
| <a name="input_ssm_parameters_endpoint_reader_description"></a> [ssm\_parameters\_endpoint\_reader\_description](#input\_ssm\_parameters\_endpoint\_reader\_description) | Description of the endpoint reader SSM parameter. | `string` | `"DNS address of the read only RDS cluser"` | no |
| <a name="input_ssm_parameters_endpoint_reader_key_name"></a> [ssm\_parameters\_endpoint\_reader\_key\_name](#input\_ssm\_parameters\_endpoint\_reader\_key\_name) | Name of the endpoint reader SSM parameter key. | `string` | `"endpointReader"` | no |
| <a name="input_ssm_parameters_export_character_set_name"></a> [ssm\_parameters\_export\_character\_set\_name](#input\_ssm\_parameters\_export\_character\_set\_name) | Export the character set namein a SSM parameter. If no character set name are provisioned, SSM parameter value will be «N/A» | `bool` | `true` | no |
| <a name="input_ssm_parameters_export_database_name"></a> [ssm\_parameters\_export\_database\_name](#input\_ssm\_parameters\_export\_database\_name) | Export the database name in a SSM parameter. If no database name are provisioned, SSM parameter value will be «N/A» | `bool` | `true` | no |
| <a name="input_ssm_parameters_export_endpoint"></a> [ssm\_parameters\_export\_endpoint](#input\_ssm\_parameters\_export\_endpoint) | Export the endpoint name in a SSM parameter. | `bool` | `true` | no |
| <a name="input_ssm_parameters_export_endpoint_reader"></a> [ssm\_parameters\_export\_endpoint\_reader](#input\_ssm\_parameters\_export\_endpoint\_reader) | Export the endpoint reader name in a SSM parameter. If provisioned engine isn't aurora, SSM parameter value will be «N/A» | `bool` | `true` | no |
| <a name="input_ssm_parameters_export_master_password"></a> [ssm\_parameters\_export\_master\_password](#input\_ssm\_parameters\_export\_master\_password) | Export the master password in a secure SSM parameter. | `bool` | `true` | no |
| <a name="input_ssm_parameters_export_master_username"></a> [ssm\_parameters\_export\_master\_username](#input\_ssm\_parameters\_export\_master\_username) | Export the master username in a secure SSM parameter. | `bool` | `true` | no |
| <a name="input_ssm_parameters_export_port"></a> [ssm\_parameters\_export\_port](#input\_ssm\_parameters\_export\_port) | Export the database port in a SSM parameter. | `bool` | `true` | no |
| <a name="input_ssm_parameters_iam_policy_create"></a> [ssm\_parameters\_iam\_policy\_create](#input\_ssm\_parameters\_iam\_policy\_create) | Create iam policy for SSM parameters and KMS key access. | `bool` | `false` | no |
| <a name="input_ssm_parameters_iam_policy_name_prefix_read_only"></a> [ssm\_parameters\_iam\_policy\_name\_prefix\_read\_only](#input\_ssm\_parameters\_iam\_policy\_name\_prefix\_read\_only) | Name of the SSM parameters IAM read only policy. | `string` | `""` | no |
| <a name="input_ssm_parameters_iam_policy_name_prefix_read_write"></a> [ssm\_parameters\_iam\_policy\_name\_prefix\_read\_write](#input\_ssm\_parameters\_iam\_policy\_name\_prefix\_read\_write) | Name of the SSM parameters IAM read write policy. | `string` | `""` | no |
| <a name="input_ssm_parameters_iam_policy_path"></a> [ssm\_parameters\_iam\_policy\_path](#input\_ssm\_parameters\_iam\_policy\_path) | Path of the SSM parameters IAM policies. | `string` | `null` | no |
| <a name="input_ssm_parameters_kms_key_alias_name"></a> [ssm\_parameters\_kms\_key\_alias\_name](#input\_ssm\_parameters\_kms\_key\_alias\_name) | Name of the alias KMS key. | `string` | `""` | no |
| <a name="input_ssm_parameters_kms_key_create"></a> [ssm\_parameters\_kms\_key\_create](#input\_ssm\_parameters\_kms\_key\_create) | Create KMS key for SSM parameters. | `bool` | `false` | no |
| <a name="input_ssm_parameters_kms_key_id"></a> [ssm\_parameters\_kms\_key\_id](#input\_ssm\_parameters\_kms\_key\_id) | ID of the kms key if toggle ssm\_parameters\_kms\_key\_create, ssm\_parameters\_use\_database\_kms\_key or ssm\_parameters\_use\_default\_kms\_key are disable. | `bool` | `false` | no |
| <a name="input_ssm_parameters_kms_key_name"></a> [ssm\_parameters\_kms\_key\_name](#input\_ssm\_parameters\_kms\_key\_name) | Name of the KMS key. | `string` | `""` | no |
| <a name="input_ssm_parameters_kms_key_tags"></a> [ssm\_parameters\_kms\_key\_tags](#input\_ssm\_parameters\_kms\_key\_tags) | Tags to be merge with all SSM parameters KMS key resources. | `map(string)` | `{}` | no |
| <a name="input_ssm_parameters_master_password_description"></a> [ssm\_parameters\_master\_password\_description](#input\_ssm\_parameters\_master\_password\_description) | Description of the master passsword SSM parameter. | `string` | `"Master password of the database"` | no |
| <a name="input_ssm_parameters_master_password_key_name"></a> [ssm\_parameters\_master\_password\_key\_name](#input\_ssm\_parameters\_master\_password\_key\_name) | Name of the master passsword SSM parameter key. | `string` | `"masterPassword"` | no |
| <a name="input_ssm_parameters_master_username_description"></a> [ssm\_parameters\_master\_username\_description](#input\_ssm\_parameters\_master\_username\_description) | Description of the master username SSM parameter. | `string` | `"Master username of the database"` | no |
| <a name="input_ssm_parameters_master_username_key_name"></a> [ssm\_parameters\_master\_username\_key\_name](#input\_ssm\_parameters\_master\_username\_key\_name) | Name of the master username SSM parameter key. | `string` | `"masterUsername"` | no |
| <a name="input_ssm_parameters_port_description"></a> [ssm\_parameters\_port\_description](#input\_ssm\_parameters\_port\_description) | Description of the database port SSM parameter. | `string` | `"Port of the database"` | no |
| <a name="input_ssm_parameters_port_key_name"></a> [ssm\_parameters\_port\_key\_name](#input\_ssm\_parameters\_port\_key\_name) | Name of the database port SSM parameter key. | `string` | `"databasePort"` | no |
| <a name="input_ssm_parameters_prefix"></a> [ssm\_parameters\_prefix](#input\_ssm\_parameters\_prefix) | Prefix to be add on all SSM parameter keys. Cannot started by «/». | `string` | `""` | no |
| <a name="input_ssm_parameters_tags"></a> [ssm\_parameters\_tags](#input\_ssm\_parameters\_tags) | Tags to be merge with all SSM parameters resources. | `map(string)` | `{}` | no |
| <a name="input_ssm_parameters_use_database_kms_key"></a> [ssm\_parameters\_use\_database\_kms\_key](#input\_ssm\_parameters\_use\_database\_kms\_key) | Use the same KMS key as for the database | `bool` | `false` | no |
| <a name="input_ssm_parameters_use_default_kms_key"></a> [ssm\_parameters\_use\_default\_kms\_key](#input\_ssm\_parameters\_use\_default\_kms\_key) | Use default AWS KMS key | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be merged with all resources of this module. | `map(string)` | `{}` | no |
| <a name="input_use_default_kms_key"></a> [use\_default\_kms\_key](#input\_use\_default\_kms\_key) | Use the default KMS key to encrypt DBs. | `bool` | `true` | no |
| <a name="input_use_num_suffix"></a> [use\_num\_suffix](#input\_use\_num\_suffix) | Always append numerical suffix to all resources. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | n/a |
| <a name="output_backup_retention_period"></a> [backup\_retention\_period](#output\_backup\_retention\_period) | n/a |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | n/a |
| <a name="output_db_instance_allocated_storage"></a> [db\_instance\_allocated\_storage](#output\_db\_instance\_allocated\_storage) | n/a |
| <a name="output_db_instance_character_set_name"></a> [db\_instance\_character\_set\_name](#output\_db\_instance\_character\_set\_name) | n/a |
| <a name="output_db_instance_domain"></a> [db\_instance\_domain](#output\_db\_instance\_domain) | n/a |
| <a name="output_db_instance_domain_iam_role_name"></a> [db\_instance\_domain\_iam\_role\_name](#output\_db\_instance\_domain\_iam\_role\_name) | n/a |
| <a name="output_db_instance_multi_az"></a> [db\_instance\_multi\_az](#output\_db\_instance\_multi\_az) | n/a |
| <a name="output_db_subnet_group_arn"></a> [db\_subnet\_group\_arn](#output\_db\_subnet\_group\_arn) | n/a |
| <a name="output_db_subnet_group_id"></a> [db\_subnet\_group\_id](#output\_db\_subnet\_group\_id) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_engine"></a> [engine](#output\_engine) | n/a |
| <a name="output_engine_version"></a> [engine\_version](#output\_engine\_version) | n/a |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | n/a |
| <a name="output_instance_arns"></a> [instance\_arns](#output\_instance\_arns) | n/a |
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | n/a |
| <a name="output_kms_key_alias_arn"></a> [kms\_key\_alias\_arn](#output\_kms\_key\_alias\_arn) | n/a |
| <a name="output_kms_key_alias_target_key_arn"></a> [kms\_key\_alias\_target\_key\_arn](#output\_kms\_key\_alias\_target\_key\_arn) | n/a |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | n/a |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | n/a |
| <a name="output_maintenance_window"></a> [maintenance\_window](#output\_maintenance\_window) | n/a |
| <a name="output_master_username"></a> [master\_username](#output\_master\_username) | n/a |
| <a name="output_option_group_arn"></a> [option\_group\_arn](#output\_option\_group\_arn) | n/a |
| <a name="output_option_group_id"></a> [option\_group\_id](#output\_option\_group\_id) | n/a |
| <a name="output_parameter_group_arn"></a> [parameter\_group\_arn](#output\_parameter\_group\_arn) | n/a |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | n/a |
| <a name="output_port"></a> [port](#output\_port) | n/a |
| <a name="output_preferred_backup_window"></a> [preferred\_backup\_window](#output\_preferred\_backup\_window) | n/a |
| <a name="output_rds_cluster_arn"></a> [rds\_cluster\_arn](#output\_rds\_cluster\_arn) | n/a |
| <a name="output_rds_cluster_availability_zones"></a> [rds\_cluster\_availability\_zones](#output\_rds\_cluster\_availability\_zones) | n/a |
| <a name="output_rds_cluster_cluster_identifier"></a> [rds\_cluster\_cluster\_identifier](#output\_rds\_cluster\_cluster\_identifier) | n/a |
| <a name="output_rds_cluster_cluster_members"></a> [rds\_cluster\_cluster\_members](#output\_rds\_cluster\_cluster\_members) | n/a |
| <a name="output_rds_cluster_id"></a> [rds\_cluster\_id](#output\_rds\_cluster\_id) | n/a |
| <a name="output_rds_cluster_instance_cluster_identifiers"></a> [rds\_cluster\_instance\_cluster\_identifiers](#output\_rds\_cluster\_instance\_cluster\_identifiers) | n/a |
| <a name="output_rds_cluster_instance_dbi_resource_ids"></a> [rds\_cluster\_instance\_dbi\_resource\_ids](#output\_rds\_cluster\_instance\_dbi\_resource\_ids) | n/a |
| <a name="output_rds_cluster_instance_endpoints"></a> [rds\_cluster\_instance\_endpoints](#output\_rds\_cluster\_instance\_endpoints) | n/a |
| <a name="output_rds_cluster_instance_engine_versions"></a> [rds\_cluster\_instance\_engine\_versions](#output\_rds\_cluster\_instance\_engine\_versions) | n/a |
| <a name="output_rds_cluster_instance_engines"></a> [rds\_cluster\_instance\_engines](#output\_rds\_cluster\_instance\_engines) | n/a |
| <a name="output_rds_cluster_instance_identifiers"></a> [rds\_cluster\_instance\_identifiers](#output\_rds\_cluster\_instance\_identifiers) | n/a |
| <a name="output_rds_cluster_instance_kms_key_ids"></a> [rds\_cluster\_instance\_kms\_key\_ids](#output\_rds\_cluster\_instance\_kms\_key\_ids) | n/a |
| <a name="output_rds_cluster_instance_performance_insights_enableds"></a> [rds\_cluster\_instance\_performance\_insights\_enableds](#output\_rds\_cluster\_instance\_performance\_insights\_enableds) | n/a |
| <a name="output_rds_cluster_instance_performance_insights_kms_key_ids"></a> [rds\_cluster\_instance\_performance\_insights\_kms\_key\_ids](#output\_rds\_cluster\_instance\_performance\_insights\_kms\_key\_ids) | n/a |
| <a name="output_rds_cluster_instance_ports"></a> [rds\_cluster\_instance\_ports](#output\_rds\_cluster\_instance\_ports) | n/a |
| <a name="output_rds_cluster_instance_storage_encrypteds"></a> [rds\_cluster\_instance\_storage\_encrypteds](#output\_rds\_cluster\_instance\_storage\_encrypteds) | n/a |
| <a name="output_rds_cluster_instance_writers"></a> [rds\_cluster\_instance\_writers](#output\_rds\_cluster\_instance\_writers) | n/a |
| <a name="output_rds_cluster_reader_endpoint"></a> [rds\_cluster\_reader\_endpoint](#output\_rds\_cluster\_reader\_endpoint) | n/a |
| <a name="output_rds_cluster_replication_source_identifier"></a> [rds\_cluster\_replication\_source\_identifier](#output\_rds\_cluster\_replication\_source\_identifier) | n/a |
| <a name="output_rds_cluster_storage_encrypted"></a> [rds\_cluster\_storage\_encrypted](#output\_rds\_cluster\_storage\_encrypted) | n/a |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | n/a |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | n/a |
| <a name="output_security_group_description"></a> [security\_group\_description](#output\_security\_group\_description) | n/a |
| <a name="output_security_group_egress"></a> [security\_group\_egress](#output\_security\_group\_egress) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
| <a name="output_security_group_ingress"></a> [security\_group\_ingress](#output\_security\_group\_ingress) | n/a |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | n/a |
| <a name="output_security_group_owner_id"></a> [security\_group\_owner\_id](#output\_security\_group\_owner\_id) | n/a |
| <a name="output_security_group_vpc_id"></a> [security\_group\_vpc\_id](#output\_security\_group\_vpc\_id) | n/a |
| <a name="output_ssm_parameters_arns"></a> [ssm\_parameters\_arns](#output\_ssm\_parameters\_arns) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_only_arn"></a> [ssm\_parameters\_iam\_policy\_read\_only\_arn](#output\_ssm\_parameters\_iam\_policy\_read\_only\_arn) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_only_description"></a> [ssm\_parameters\_iam\_policy\_read\_only\_description](#output\_ssm\_parameters\_iam\_policy\_read\_only\_description) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_only_id"></a> [ssm\_parameters\_iam\_policy\_read\_only\_id](#output\_ssm\_parameters\_iam\_policy\_read\_only\_id) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_only_name"></a> [ssm\_parameters\_iam\_policy\_read\_only\_name](#output\_ssm\_parameters\_iam\_policy\_read\_only\_name) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_only_path"></a> [ssm\_parameters\_iam\_policy\_read\_only\_path](#output\_ssm\_parameters\_iam\_policy\_read\_only\_path) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_only_policy"></a> [ssm\_parameters\_iam\_policy\_read\_only\_policy](#output\_ssm\_parameters\_iam\_policy\_read\_only\_policy) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_write_arn"></a> [ssm\_parameters\_iam\_policy\_read\_write\_arn](#output\_ssm\_parameters\_iam\_policy\_read\_write\_arn) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_write_description"></a> [ssm\_parameters\_iam\_policy\_read\_write\_description](#output\_ssm\_parameters\_iam\_policy\_read\_write\_description) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_write_id"></a> [ssm\_parameters\_iam\_policy\_read\_write\_id](#output\_ssm\_parameters\_iam\_policy\_read\_write\_id) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_write_name"></a> [ssm\_parameters\_iam\_policy\_read\_write\_name](#output\_ssm\_parameters\_iam\_policy\_read\_write\_name) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_write_path"></a> [ssm\_parameters\_iam\_policy\_read\_write\_path](#output\_ssm\_parameters\_iam\_policy\_read\_write\_path) | n/a |
| <a name="output_ssm_parameters_iam_policy_read_write_policy"></a> [ssm\_parameters\_iam\_policy\_read\_write\_policy](#output\_ssm\_parameters\_iam\_policy\_read\_write\_policy) | n/a |
| <a name="output_ssm_parameters_kms_alias_arn"></a> [ssm\_parameters\_kms\_alias\_arn](#output\_ssm\_parameters\_kms\_alias\_arn) | n/a |
| <a name="output_ssm_parameters_kms_alias_target_key_arn"></a> [ssm\_parameters\_kms\_alias\_target\_key\_arn](#output\_ssm\_parameters\_kms\_alias\_target\_key\_arn) | n/a |
| <a name="output_ssm_parameters_kms_key_arn"></a> [ssm\_parameters\_kms\_key\_arn](#output\_ssm\_parameters\_kms\_key\_arn) | n/a |
| <a name="output_ssm_parameters_kms_key_id"></a> [ssm\_parameters\_kms\_key\_id](#output\_ssm\_parameters\_kms\_key\_id) | n/a |
| <a name="output_ssm_parameters_names"></a> [ssm\_parameters\_names](#output\_ssm\_parameters\_names) | n/a |
| <a name="output_ssm_parameters_types"></a> [ssm\_parameters\_types](#output\_ssm\_parameters\_types) | n/a |
| <a name="output_ssm_parameters_versions"></a> [ssm\_parameters\_versions](#output\_ssm\_parameters\_versions) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
