# RDS cluster with KMS key creation example

Create a RDS cluster with a KMS key.

## Usage

To run this example, you need to execute:

```
$ terraform init
$ terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 2.57 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 2.57 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms_key"></a> [kms\_key](#module\_kms\_key) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_string.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_subnet_ids.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | Credentials: AWS access key. | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Credentials: AWS secret key. Pass this as a variable, never write password in the code. | `string` | n/a | yes |

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
