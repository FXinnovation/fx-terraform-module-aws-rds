# terraform-module-aws-rds

Terraform module that helps you create a RDS instance.

This module can create :
  * 1 RDS cluster with n RDS cluster endpoint OR 1 RDS db instance (dynamicly choosen depending the engine)
  * 1 option group (if not RDS cluster)
  * 1 parameter group / cluster parameter group (dynamicly choosen depending the engine)
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
| terraform | >= 0.12 |
| aws | ~>2.57 |

## Providers

| Name | Version |
|------|---------|
| aws | ~>2.57 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additionnal\_security\_group | Additionnal security group to add to db. | `list(string)` | `[]` | no |
| apply\_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| auto\_minor\_version\_upgrade | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. | `bool` | `true` | no |
| backtrack\_window | The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0 | `number` | `0` | no |
| backup\_retention\_period | The number of days to retain backups for. Default 1 | `number` | `1` | no |
| ca\_cert\_identifier | he daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC | `string` | `null` | no |
| cloudwatch\_logs\_exports | List of log types to export to cloudwatch. | `list(string)` | `[]` | no |
| copy\_tags\_to\_snapshot | Copy all Cluster tags to snapshots. Default is false. | `bool` | `false` | no |
| create\_ssm\_parameters | Create SMM parameters related to database informations | `bool` | `false` | no |
| database\_identifier | The database identifier | `string` | `""` | no |
| database\_name | Name for an automatically created database on cluster creation. | `string` | `null` | no |
| db\_instance\_allocated\_storage | The allocated storage in gibibytes. | `number` | `null` | no |
| db\_instance\_allow\_major\_version\_upgrade | Indicates that major version upgrades are allowed. | `bool` | `false` | no |
| db\_instance\_availability\_zone | Availability zone for the instance. | `string` | `null` | no |
| db\_instance\_character\_set\_name | The character set name to use for DB encoding in Oracle instances. | `string` | `null` | no |
| db\_instance\_delete\_automated\_backups | Specifies whether to remove automated backups immediately after the DB instance is deleted. | `bool` | `true` | no |
| db\_instance\_domain | The ID of the Directory Service Active Directory domain to create the instance in. | `string` | `null` | no |
| db\_instance\_domain\_iam\_role\_name | The name of the IAM role to be used when making API calls to the Directory Service. | `string` | `null` | no |
| db\_instance\_global\_tags | Tags to be merge to all db instances | `map(string)` | `{}` | no |
| db\_instance\_instance\_class | Instance classes to use. | `string` | `null` | no |
| db\_instance\_iops | The amount of provisioned IOPS. Setting this implies a storage\_type of "io1". | `number` | `null` | no |
| db\_instance\_license\_model | License model information for this DB instance. | `string` | `null` | no |
| db\_instance\_max\_allocated\_storage | When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. | `number` | `null` | no |
| db\_instance\_multi\_az | Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| db\_instance\_performance\_insights\_retention\_period | The amount of time in days to retain Performance Insights data | `number` | `null` | no |
| db\_instance\_promotion\_tiers | List of number for failover Priority setting on instance level. This will be use for the master election, and, load balancing into the cluster. | `list(number)` | `null` | no |
| db\_instance\_replicate\_source\_db | Specifies that this resource is a Replicate database, and to use this value as the source database. | `string` | `null` | no |
| db\_instance\_storage\_type | One of "standard" (magnetic), "gp2" (general purpose SSD), or "io1" (provisioned IOPS SSD). | `string` | `null` | no |
| db\_instance\_tags | List of Tags to be merge to each db instances | `list(map(string))` | `[]` | no |
| db\_instance\_timezone | Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. | `string` | `null` | no |
| db\_subnet\_group\_name | The name of the DB subnet group. | `string` | `null` | no |
| db\_subnet\_group\_subnet\_ids | A list of VPC subnet IDs. | `list(string)` | `[]` | no |
| db\_subnet\_group\_tags | Map of tags to be nerge with db subnet group | `map(string)` | `{}` | no |
| deletion\_protection | If the DB instance should have deletion protection enabled. | `bool` | `false` | no |
| description | Description to be added on security\_group, rds\_parameter\_group, kms\_key and db\_subnet\_group. | `string` | `null` | no |
| enable | Enable this module. | `bool` | `true` | no |
| enable\_s3\_import | Enable S3 import | `bool` | `false` | no |
| engine | The name of the database engine to be used for this DB | `string` | `null` | no |
| engine\_mode | The database engine mode. | `string` | `null` | no |
| engine\_version | The database engine version. | `string` | `null` | no |
| final\_snapshot\_identifier\_prefix | The prefix name of your final DB snapshot when this DB cluster is deleted. This will be suffixed by a 5 digits random id managed by terraform. | `string` | `null` | no |
| iam\_database\_authentication\_enabled | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled. | `bool` | `false` | no |
| kms\_key\_alias\_name | Alias of the KMS key | `string` | `null` | no |
| kms\_key\_create | Create a kms key for database | `bool` | `false` | no |
| kms\_key\_create\_alias | Create a kms key alias for database | `bool` | `false` | no |
| kms\_key\_id | ID of KMS key used for database encryption. | `string` | `null` | no |
| kms\_key\_name | Name of the KMS if kms\_key\_create is set to true. | `string` | `null` | no |
| kms\_key\_policy\_json | Policy of the KMS Key | `string` | `null` | no |
| kms\_key\_tags | Tags to be merged with all KMS key resources | `map(string)` | `{}` | no |
| master\_password | Password for the master DB user. | `string` | `null` | no |
| master\_username | Username for the master DB user. | `string` | `null` | no |
| monitoring\_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. | `number` | `null` | no |
| monitoring\_role\_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `string` | `null` | no |
| num\_suffix\_digits | Number of significant digits to append to instances name. | `number` | `2` | no |
| option\_group\_engine\_name | Specifies the name of the engine that this option group should be associated with. | `string` | `null` | no |
| option\_group\_major\_engine\_version | Specifies the major version of the engine that this option group should be associated with. | `string` | `null` | no |
| option\_group\_name | The name of the option group. | `string` | `null` | no |
| option\_group\_options | A list of map of Options to apply. Map must support the following structure:<br>  * option\_name (required, string): The Name of the Option (e.g. MEMCACHED).<br>  * port (optional, number): The Port number when connecting to the Option (e.g. 11211).<br>  * version (optional, string): The version of the option (e.g. 13.1.0.0).<br>  * db\_security\_group\_memberships (optional, string): A list of DB Security Groups for which the option is enabled.<br>  * vpc\_security\_group\_memberships (optional, string): A list of VPC Security Groups for which the option is enabled.<br>  * option\_settings (required, list of map): A list of map of option settings to apply:<br>    * name (required, string): The Name of the setting.<br>    * value (required, string): The Value of the setting.<br><br>For example, see folder examples/db\_instance\_with\_option\_group. | `any` | `[]` | no |
| option\_group\_tags | Tags to be merge with the DB option group resource. | `map(string)` | `{}` | no |
| parameter\_group\_family | The family of the DB parameter group | `string` | `null` | no |
| parameter\_group\_name | The name of the DB parameter group. | `string` | `null` | no |
| parameter\_group\_parameters | List of map of parameter to add. apply\_method can be immediate or pending-reboot. | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| parameter\_group\_tags | Tags to be added with parameter group | `map(string)` | `{}` | no |
| performance\_insights\_enabled | Specifies whether Performance Insights is enabled or not. | `bool` | `false` | no |
| performance\_insights\_kms\_key\_id | The ARN for the KMS key to encrypt Performance Insights data. | `string` | `null` | no |
| port | The database port | `number` | `null` | no |
| preferred\_backup\_window | The daily time range during which automated backups are created if automated backups are enabled. Time in UTC, e.g. 04:00-09:00 | `string` | `null` | no |
| preferred\_maintenance\_window | The weekly window to perform maintenance in. Time in UTC  e.g. wed:04:00-wed:04:30 | `string` | `null` | no |
| prefix | Prefix to be added to all resources, execpt SSM paramter keys. To prefix SSM parameter keys, see `ssm_parameters_prefix`. | `string` | `""` | no |
| publicly\_accessible | Bool to control if instance is publicly accessible. | `bool` | `false` | no |
| rds\_cluster\_enable\_http\_endpoint | Enable HTTP endpoint (data API). Only valid when engine\_mode is set to serverless. | `bool` | `false` | no |
| rds\_cluster\_enable\_s3\_import | Enable S3 import on RDS database creation | `bool` | `false` | no |
| rds\_cluster\_enable\_scaling\_configuration | Enable scalling configuration. Only valid when engine\_mode is set to serverless. | `bool` | `false` | no |
| rds\_cluster\_global\_cluster\_identifier | The global cluster identifier. | `string` | `null` | no |
| rds\_cluster\_iam\_roles | A List of ARNs for the IAM roles to associate to the RDS Cluster. | `list(string)` | `[]` | no |
| rds\_cluster\_identifier | The global cluster identifier. | `string` | `""` | no |
| rds\_cluster\_replication\_source\_identifier | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. | `string` | `null` | no |
| rds\_cluster\_scaling\_configuration\_auto\_pause | Whether to enable automatic pause. A DB cluster can be paused only when it's idle (it has no connections). | `string` | `null` | no |
| rds\_cluster\_scaling\_configuration\_max\_capacity | The maximum capacity. | `number` | `null` | no |
| rds\_cluster\_scaling\_configuration\_min\_capacity | The minimum capacity. | `number` | `null` | no |
| rds\_cluster\_scaling\_configuration\_seconds\_until\_auto\_pause | The time, in seconds, before an Aurora DB cluster in serverless mode is paused. | `number` | `null` | no |
| rds\_cluster\_scaling\_configuration\_timeout\_action | The action to take when the timeout is reached. | `string` | `null` | no |
| rds\_cluster\_source\_region | The source region for an encrypted replica DB. | `string` | `null` | no |
| rds\_cluster\_tags | Tags to be merged to RDS cluster | `map(string)` | `{}` | no |
| rds\_instance\_availability\_zones | List of the EC2 Availability Zone that each DB instance are created in. | `list(string)` | `[]` | no |
| rds\_instance\_instance\_classes | List of instance classes to use. | `list(string)` | `[]` | no |
| rds\_instance\_promotion\_tiers | List of number for failover Priority setting on instance level | `list(number)` | `null` | no |
| s3\_import\_bucket\_name | The bucket name where your backup is stored. | `string` | `null` | no |
| s3\_import\_bucket\_prefix | Can be blank, but is the path to your backup | `string` | `null` | no |
| s3\_import\_ingestion\_role | Role applied to load the data. | `string` | `null` | no |
| s3\_import\_source\_engine | Source engine for the backup | `string` | `null` | no |
| s3\_import\_source\_engine\_version | Version of source engine for the backup | `string` | `null` | no |
| security\_group\_name | Name of the security group | `string` | `""` | no |
| security\_group\_source\_cidrs | List for CIDR to add as inbound address in the security group. | `list(string)` | `[]` | no |
| security\_group\_source\_security\_group | List of security group id to be add as source security group | `list(string)` | `[]` | no |
| security\_group\_tags | Tags to be merged to the security group | `map(string)` | `{}` | no |
| security\_group\_vpc\_id | ID of the VPC | `string` | `null` | no |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB cluster is deleted. | `bool` | `true` | no |
| snapshot\_identifier | The name of your final DB snapshot when this DB cluster is deleted. | `string` | `null` | no |
| ssm\_parameters\_character\_set\_name\_description | Description of the character set name SSM parameter. | `string` | `"Character set name of the database"` | no |
| ssm\_parameters\_character\_set\_name\_key\_name | Name of the character set name SSM parameter key. | `string` | `"characterSetName"` | no |
| ssm\_parameters\_database\_name\_description | Description of the database name SSM parameter. | `string` | `"Database name created by AWS"` | no |
| ssm\_parameters\_database\_name\_key\_name | Name of the database name SSM parameter key. | `string` | `"databaseName"` | no |
| ssm\_parameters\_endpoint\_description | Description of the endpoint SSM parameter. | `string` | `"DNS address of the database"` | no |
| ssm\_parameters\_endpoint\_key\_name | Name of the endpoint SSM parameter key. | `string` | `"endpoint"` | no |
| ssm\_parameters\_endpoint\_reader\_description | Description of the endpoint reader SSM parameter. | `string` | `"DNS address of the read only RDS cluser"` | no |
| ssm\_parameters\_endpoint\_reader\_key\_name | Name of the endpoint reader SSM parameter key. | `string` | `"endpointReader"` | no |
| ssm\_parameters\_export\_character\_set\_name | Export the character set namein a SSM parameter. If no character set name are provisioned, SSM parameter value will be «N/A» | `bool` | `true` | no |
| ssm\_parameters\_export\_database\_name | Export the database name in a SSM parameter. If no database name are provisioned, SSM parameter value will be «N/A» | `bool` | `true` | no |
| ssm\_parameters\_export\_endpoint | Export the endpoint name in a SSM parameter. | `bool` | `true` | no |
| ssm\_parameters\_export\_endpoint\_reader | Export the endpoint reader name in a SSM parameter. If provisioned engine isn't aurora, SSM parameter value will be «N/A» | `bool` | `true` | no |
| ssm\_parameters\_export\_master\_password | Export the master password in a secure SSM parameter. | `bool` | `true` | no |
| ssm\_parameters\_export\_master\_username | Export the master username in a secure SSM parameter. | `bool` | `true` | no |
| ssm\_parameters\_export\_port | Export the database port in a SSM parameter. | `bool` | `true` | no |
| ssm\_parameters\_iam\_policy\_create | Create iam policy for SSM parameters and KMS key access. | `bool` | `false` | no |
| ssm\_parameters\_iam\_policy\_name\_prefix\_read\_only | Name of the SSM parameters IAM read only policy. | `string` | `""` | no |
| ssm\_parameters\_iam\_policy\_name\_prefix\_read\_write | Name of the SSM parameters IAM read write policy. | `string` | `""` | no |
| ssm\_parameters\_iam\_policy\_path | Path of the SSM parameters IAM policies. | `string` | `null` | no |
| ssm\_parameters\_kms\_key\_alias\_name | Name of the alias KMS key. | `string` | `""` | no |
| ssm\_parameters\_kms\_key\_create | Create KMS key for SSM parameters. | `bool` | `false` | no |
| ssm\_parameters\_kms\_key\_id | ID of the kms key if toggle ssm\_parameters\_kms\_key\_create, ssm\_parameters\_use\_database\_kms\_key or ssm\_parameters\_use\_default\_kms\_key are disable. | `bool` | `false` | no |
| ssm\_parameters\_kms\_key\_name | Name of the KMS key. | `string` | `""` | no |
| ssm\_parameters\_kms\_key\_tags | Tags to be merge with all SSM parameters KMS key resources. | `map(string)` | `{}` | no |
| ssm\_parameters\_master\_pasword\_description | Description of the master passsword SSM parameter. | `string` | `"Master password of the database"` | no |
| ssm\_parameters\_master\_pasword\_key\_name | Name of the master passsword SSM parameter key. | `string` | `"masterPassword"` | no |
| ssm\_parameters\_master\_username\_description | Description of the master username SSM parameter. | `string` | `"Master username of the database"` | no |
| ssm\_parameters\_master\_username\_key\_name | Name of the master username SSM parameter key. | `string` | `"masterUsername"` | no |
| ssm\_parameters\_port\_description | Description of the database port SSM parameter. | `string` | `"Port of the database"` | no |
| ssm\_parameters\_port\_key\_name | Name of the database port SSM parameter key. | `string` | `"databasePort"` | no |
| ssm\_parameters\_prefix | Prefix to be add on all SSM parameter keys. Cannot started by «/». | `string` | `""` | no |
| ssm\_parameters\_tags | Tags to be merge with all SSM parameters resources. | `map(string)` | `{}` | no |
| ssm\_parameters\_use\_database\_kms\_key | Use the same KMS key as for the database | `bool` | `false` | no |
| ssm\_parameters\_use\_default\_kms\_key | Use default AWS KMS key | `bool` | `false` | no |
| tags | Tags to be merged with all resources of this module. | `map(string)` | `{}` | no |
| use\_default\_kms\_key | Use the default KMS key to encrypt DBs. | `bool` | `true` | no |
| use\_num\_suffix | Always append numerical suffix to all resources. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| availability\_zones | n/a |
| backup\_retention\_period | n/a |
| database\_name | n/a |
| db\_instance\_allocated\_storage | n/a |
| db\_instance\_character\_set\_name | n/a |
| db\_instance\_domain | n/a |
| db\_instance\_domain\_iam\_role\_name | n/a |
| db\_instance\_multi\_az | n/a |
| db\_subnet\_group\_arn | n/a |
| db\_subnet\_group\_id | n/a |
| endpoint | n/a |
| engine | n/a |
| engine\_version | n/a |
| hosted\_zone\_id | n/a |
| instance\_arns | n/a |
| instance\_ids | n/a |
| kms\_key\_alias\_arn | n/a |
| kms\_key\_alias\_target\_key\_arn | n/a |
| kms\_key\_arn | n/a |
| kms\_key\_id | n/a |
| maintenance\_window | n/a |
| master\_username | n/a |
| option\_group\_arn | n/a |
| option\_group\_id | n/a |
| parameter\_group\_arn | n/a |
| parameter\_group\_id | n/a |
| port | n/a |
| preferred\_backup\_window | n/a |
| rds\_cluster\_arn | n/a |
| rds\_cluster\_availability\_zones | n/a |
| rds\_cluster\_cluster\_identifier | n/a |
| rds\_cluster\_cluster\_members | n/a |
| rds\_cluster\_id | n/a |
| rds\_cluster\_instance\_cluster\_identifiers | n/a |
| rds\_cluster\_instance\_dbi\_resource\_ids | n/a |
| rds\_cluster\_instance\_endpoints | n/a |
| rds\_cluster\_instance\_engine\_versions | n/a |
| rds\_cluster\_instance\_engines | n/a |
| rds\_cluster\_instance\_identifiers | n/a |
| rds\_cluster\_instance\_kms\_key\_ids | n/a |
| rds\_cluster\_instance\_performance\_insights\_enableds | n/a |
| rds\_cluster\_instance\_performance\_insights\_kms\_key\_ids | n/a |
| rds\_cluster\_instance\_ports | n/a |
| rds\_cluster\_instance\_storage\_encrypteds | n/a |
| rds\_cluster\_instance\_writers | n/a |
| rds\_cluster\_reader\_endpoint | n/a |
| rds\_cluster\_replication\_source\_identifier | n/a |
| rds\_cluster\_storage\_encrypted | n/a |
| resource\_id | n/a |
| security\_group\_arn | n/a |
| security\_group\_description | n/a |
| security\_group\_egress | n/a |
| security\_group\_id | n/a |
| security\_group\_ingress | n/a |
| security\_group\_name | n/a |
| security\_group\_owner\_id | n/a |
| security\_group\_vpc\_id | n/a |
| ssm\_parameters\_arns | n/a |
| ssm\_parameters\_iam\_policy\_read\_only\_arn | n/a |
| ssm\_parameters\_iam\_policy\_read\_only\_description | n/a |
| ssm\_parameters\_iam\_policy\_read\_only\_id | n/a |
| ssm\_parameters\_iam\_policy\_read\_only\_name | n/a |
| ssm\_parameters\_iam\_policy\_read\_only\_path | n/a |
| ssm\_parameters\_iam\_policy\_read\_only\_policy | n/a |
| ssm\_parameters\_iam\_policy\_read\_write\_arn | n/a |
| ssm\_parameters\_iam\_policy\_read\_write\_description | n/a |
| ssm\_parameters\_iam\_policy\_read\_write\_id | n/a |
| ssm\_parameters\_iam\_policy\_read\_write\_name | n/a |
| ssm\_parameters\_iam\_policy\_read\_write\_path | n/a |
| ssm\_parameters\_iam\_policy\_read\_write\_policy | n/a |
| ssm\_parameters\_kms\_alias\_arn | n/a |
| ssm\_parameters\_kms\_alias\_target\_key\_arn | n/a |
| ssm\_parameters\_kms\_key\_arn | n/a |
| ssm\_parameters\_kms\_key\_id | n/a |
| ssm\_parameters\_names | n/a |
| ssm\_parameters\_types | n/a |
| ssm\_parameters\_versions | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
