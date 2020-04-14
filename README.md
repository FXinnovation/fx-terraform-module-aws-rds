# terraform-module-aws-rds

Terraform module that helps you create a RDS instance.

## Limitations:

This module doesn't support RDS global cluster creation. There is an issue with deletion :

```
error deleting RDS Cluster (nsu6suhxtftest-00001): InvalidDBClusterStateFault: This cluster is a part of a global cluster, please remove it from globalcluster first
```

No KMS key created internall for performance insights. Must be given externally.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | ~>2.57.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~>2.57.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additionnal\_security\_group | Additionnal security group to add to db. | `list(string)` | `[]` | no |
| apply\_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| auto\_minor\_version\_upgrade | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. | `bool` | `true` | no |
| backtrack\_window | The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0 | `number` | `0` | no |
| backup\_retention\_period | The number of days to retain backups for. Default 1 | `number` | `1` | no |
| copy\_tags\_to\_snapshot | Copy all Cluster tags to snapshots. Default is false. | `bool` | `false` | no |
| database\_identifier | The database identifier | `string` | `""` | no |
| database\_name | Name for an automatically created database on cluster creation. | `string` | `null` | no |
| db\_instance\_availability\_zones | List of the EC2 Availability Zone that each DB instance are created in. | `list(string)` | `[]` | no |
| db\_instance\_ca\_cert\_identifier | The identifier of the CA certificate for the DB instance. | `string` | `null` | no |
| db\_instance\_global\_tags | Tags to be merge to all db instances | `map(string)` | `{}` | no |
| db\_instance\_instance\_classes | List of instance classes to use. | `list(string)` | `[]` | no |
| db\_instance\_monitoring\_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. | `number` | `null` | no |
| db\_instance\_monitoring\_role\_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `string` | `null` | no |
| db\_instance\_performance\_insights\_enabled | Specifies whether Performance Insights is enabled or not. | `bool` | `false` | no |
| db\_instance\_performance\_insights\_kms\_key\_id | The ARN for the KMS key to encrypt Performance Insights data. | `string` | `null` | no |
| db\_instance\_promotion\_tiers | List of number for failover Priority setting on instance level. This will be use for the master election, and, load balancing into the cluster. | `list(number)` | `null` | no |
| db\_instance\_publicly\_accessible | Bool to control if instance is publicly accessible. | `bool` | `false` | no |
| db\_instance\_tags | List of Tags to be merge to each db instances | `list(map(string))` | `[]` | no |
| db\_subnet\_group\_name | The name of the DB subnet group. | `string` | `null` | no |
| db\_subnet\_group\_subnet\_ids | A list of VPC subnet IDs. | `list(string)` | `[]` | no |
| db\_subnet\_group\_tags | Map of tags to be nerge with db subnet group | `map(string)` | `{}` | no |
| deletion\_protection | If the DB instance should have deletion protection enabled. | `bool` | `false` | no |
| description | Description to be added on security\_group, rds\_parameter\_group, kms\_key and db\_subnet\_group. | `string` | `null` | no |
| enable | Enable this module. | `bool` | `true` | no |
| engine | The name of the database engine to be used for this DB | `string` | `null` | no |
| engine\_mode | The database engine mode. | `string` | `null` | no |
| engine\_version | The database engine version. | `string` | `null` | no |
| final\_snapshot\_identifier\_prefix | The prefix name of your final DB snapshot when this DB cluster is deleted. This will be suffixed by a 5 digits random id managed by terraform. | `string` | `null` | no |
| kms\_key\_alias\_name | Alias of the KMS key | `string` | `null` | no |
| kms\_key\_create | Create a kms key for database | `bool` | `false` | no |
| kms\_key\_create\_alias | Create a kms key alias for database | `bool` | `false` | no |
| kms\_key\_id | ID of KMS key used for database encryption. | `string` | `null` | no |
| kms\_key\_name | Name of the KMS if kms\_key\_create is set to true. | `string` | `null` | no |
| kms\_key\_policy\_json | Policy of the KMS Key | `string` | `null` | no |
| kms\_key\_tags | Tags to be merged with all KMS key resources | `map(string)` | `{}` | no |
| master\_password | Password for the master DB user. | `string` | `null` | no |
| master\_username | Username for the master DB user. | `string` | `null` | no |
| num\_suffix\_digits | Number of significant digits to append to instances name. | `number` | `2` | no |
| port | The database port | `number` | `null` | no |
| preferred\_backup\_window | The daily time range during which automated backups are created if automated backups are enabled. Time in UTC, e.g. 04:00-09:00 | `string` | `null` | no |
| preferred\_maintenance\_window | The weekly window to perform maintenance in. Time in UTC  e.g. wed:04:00-wed:04:30 | `string` | `null` | no |
| prefix | Prefix to be added to all resources. | `string` | `""` | no |
| rds\_cluster\_enable\_http\_endpoint | Enable HTTP endpoint (data API). Only valid when engine\_mode is set to serverless. | `bool` | `false` | no |
| rds\_cluster\_enable\_s3\_import | Enable S3 import on RDS database creation | `bool` | `false` | no |
| rds\_cluster\_enable\_scaling\_configuration | Enable scaling configuration. Only valid when engine\_mode is set to serverless. | `bool` | `false` | no |
| rds\_cluster\_enabled\_cloudwatch\_logs\_exports | List of log types to export to cloudwatch. | `list(string)` | `[]` | no |
| rds\_cluster\_global\_cluster\_identifier | The global cluster identifier. | `string` | `null` | no |
| rds\_cluster\_iam\_database\_authentication\_enabled | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled. | `bool` | `false` | no |
| rds\_cluster\_iam\_roles | A List of ARNs for the IAM roles to associate to the RDS Cluster. | `list(string)` | `[]` | no |
| rds\_cluster\_identifier | The global cluster identifier. | `string` | `""` | no |
| rds\_cluster\_parameter\_group\_family | The family of the DB cluster parameter group | `string` | `null` | no |
| rds\_cluster\_parameter\_group\_name | The name of the DB cluster parameter group. | `string` | `null` | no |
| rds\_cluster\_parameter\_group\_parameters | List of map of parameter to add. apply\_method can be immediate or pending-reboot. | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| rds\_cluster\_parameter\_group\_tags | Tags to be added with parameter group | `map(string)` | `{}` | no |
| rds\_cluster\_replication\_source\_identifier | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. | `string` | `null` | no |
| rds\_cluster\_s3\_import\_bucket\_name | The bucket name where your backup is stored. | `string` | `null` | no |
| rds\_cluster\_s3\_import\_bucket\_prefix | Can be blank, but is the path to your backup | `string` | `null` | no |
| rds\_cluster\_s3\_import\_ingestion\_role | Role applied to load the data. | `string` | `null` | no |
| rds\_cluster\_s3\_import\_source\_engine | Source engine for the backup | `string` | `null` | no |
| rds\_cluster\_s3\_import\_source\_engine\_version | Version of the source engine used to make the backup | `string` | `null` | no |
| rds\_cluster\_scaling\_configuration\_auto\_pause | Whether to enable automatic pause. A DB cluster can be paused only when it's idle (it has no connections). | `string` | `null` | no |
| rds\_cluster\_scaling\_configuration\_max\_capacity | The maximum capacity. | `number` | `null` | no |
| rds\_cluster\_scaling\_configuration\_min\_capacity | The minimum capacity. | `number` | `null` | no |
| rds\_cluster\_scaling\_configuration\_seconds\_until\_auto\_pause | The time, in seconds, before an Aurora DB cluster in serverless mode is paused. | `number` | `null` | no |
| rds\_cluster\_scaling\_configuration\_timeout\_action | The action to take when the timeout is reached. | `string` | `null` | no |
| rds\_cluster\_skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB cluster is deleted. | `bool` | `true` | no |
| rds\_cluster\_snapshot\_identifier | The name of your final DB snapshot when this DB cluster is deleted. | `string` | `null` | no |
| rds\_cluster\_source\_region | The source region for an encrypted replica DB cluster. | `string` | `null` | no |
| rds\_cluster\_tags | Tags to be merged to RDS cluster | `map(string)` | `{}` | no |
| security\_group\_name | Name of the security group | `string` | `""` | no |
| security\_group\_source\_cidrs | List for CIDR to add as inbound address in the security group. | `list(string)` | `[]` | no |
| security\_group\_source\_security\_group | List of security group id to be add as source security group | `list(string)` | `[]` | no |
| security\_group\_tags | Tags to be merged to the security group | `map(string)` | `{}` | no |
| security\_group\_vpc\_id | ID of the VPC | `string` | `null` | no |
| tags | Tags to be merged with all resources of this module. | `map(string)` | `{}` | no |
| use\_default\_kms\_key | Use the default KMS key to encrypt DBs. | `bool` | `true` | no |
| use\_num\_suffix | Always append numerical suffix to all resources. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| db\_subnet\_group\_arn | n/a |
| db\_subnet\_group\_id | n/a |
| kms\_key\_alias\_arn | n/a |
| kms\_key\_alias\_target\_key\_arn | n/a |
| kms\_key\_arn | n/a |
| kms\_key\_id | n/a |
| rds\_cluster\_arn | n/a |
| rds\_cluster\_availability\_zones | n/a |
| rds\_cluster\_backup\_retention\_period | n/a |
| rds\_cluster\_cluster\_identifier | n/a |
| rds\_cluster\_cluster\_members | n/a |
| rds\_cluster\_cluster\_resource\_id | n/a |
| rds\_cluster\_database\_name | n/a |
| rds\_cluster\_endpoint | n/a |
| rds\_cluster\_engine | n/a |
| rds\_cluster\_engine\_version | n/a |
| rds\_cluster\_hosted\_zone\_id | n/a |
| rds\_cluster\_id | n/a |
| rds\_cluster\_instance\_arns | n/a |
| rds\_cluster\_instance\_availability\_zones | n/a |
| rds\_cluster\_instance\_cluster\_identifiers | n/a |
| rds\_cluster\_instance\_dbi\_resource\_ids | n/a |
| rds\_cluster\_instance\_endpoints | n/a |
| rds\_cluster\_instance\_engine\_versions | n/a |
| rds\_cluster\_instance\_engines | n/a |
| rds\_cluster\_instance\_identifiers | n/a |
| rds\_cluster\_instance\_ids | n/a |
| rds\_cluster\_instance\_kms\_key\_ids | n/a |
| rds\_cluster\_instance\_performance\_insights\_enableds | n/a |
| rds\_cluster\_instance\_performance\_insights\_kms\_key\_ids | n/a |
| rds\_cluster\_instance\_ports | n/a |
| rds\_cluster\_instance\_storage\_encrypteds | n/a |
| rds\_cluster\_instance\_writers | n/a |
| rds\_cluster\_master\_username | n/a |
| rds\_cluster\_parameter\_group\_arn | n/a |
| rds\_cluster\_parameter\_group\_id | n/a |
| rds\_cluster\_port | n/a |
| rds\_cluster\_preferred\_backup\_window | n/a |
| rds\_cluster\_preferred\_maintenance\_window | n/a |
| rds\_cluster\_reader\_endpoint | n/a |
| rds\_cluster\_replication\_source\_identifier | n/a |
| rds\_cluster\_storage\_encrypted | n/a |
| security\_group\_arn | n/a |
| security\_group\_description | n/a |
| security\_group\_egress | n/a |
| security\_group\_id | n/a |
| security\_group\_ingress | n/a |
| security\_group\_name | n/a |
| security\_group\_owner\_id | n/a |
| security\_group\_vpc\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
