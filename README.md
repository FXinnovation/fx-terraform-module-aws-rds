# terraform-module-aws-rds

Terraform module that helps you create a RDS instance.

**NOTE:** This terraform module is opinionated. It will ship with default values that fit our own needs, but you can overwrite them if needed.

## Usage

Please have a look at the examples folder to have a couple of examples of usage.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Tests

All of our releases are tested on our own AWS account. In addition to classic convergence tests we also use [inspec](https://inspec.io) to validate our deployments. This also means an inspec profile to test this module is available and can be referenced in you own inspec tests.
