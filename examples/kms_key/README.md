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
| terraform | >= 0.12 |
| aws | ~> 2 |
| aws | ~> 2.57 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2 ~> 2.57 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_key | Credentials: AWS access key. | `string` | n/a | yes |
| secret\_key | Credentials: AWS secret key. Pass this as a variable, never write password in the code. | `string` | n/a | yes |

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
