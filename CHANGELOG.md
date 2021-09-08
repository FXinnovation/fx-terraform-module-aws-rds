# CHANGELOG

## 4.0.0

* (BREAKING) chore: pins `pre-commit-hooks` to `v4.0.1`.
* feat: add `pre-commit-afcmf` (`v0.1.2`).
* chore: pins `pre-commit-terraform` to `v1.50.0`.
* chore: pins `terraform` to `>= 0.14`.
* chore: pins `aws` provider to `>= 3.0`.
* chore: bumps `terraform` + providers versions in example:
  * pins `terraform` to `>= 0.14`.
  * pins `aws` provider to `>= 3.0`.
* chore: pins ssm-parameters module to latest version (`v5.0.0`).
* refactor: example test cases:
  * get rid of `disable` example.
  * move example `rds-cluster` to `default`
    according to the naming convention in the others modules,
    we should always have at least a default example case.
  * add providers.tf files
  * update versions.tf files with proper version contraints
  * update main.tf, get rid of aws provider stanza
* refactor: lint code in root module.
* fix: update LICENSE file.

## 3.0.2
  * feat: update pre-commit
  * fix: main.tf change ssm version from 3.0.1 to 3.0.2

## 3.0.1

  * chore: bump pre-commit hooks
  * fix: in versions.tf change from `~> 2.57` to `>= 2.57, < 4.0`

## 3.0.0

  * feat: (BREAKING) Create SG rule for client and rename variable

## 2.1.0

  * maintenance: bump SSM parameters module to 3.0.1
  * fix: typo in versions.tf to be usable with terraform 0.13

## 2.0.0

  * fix (BREAKING): rename `ssm_parameters_master_password_key_name` and `ssm_parameters_master_password_description`

## 1.0.0

  * feat: init
