#
# inspec-profile::aws-rds-db-instance
# controls::default
#
# author:cloudsquad
# description: Controls for aws-rds-db-instance example
#

statefile_content = File.read(
  File.join(
    File.dirname(__FILE__), "../../../examples/db_instance/terraform.tfstate"
  )
)
outputs = JSON.parse(statefile_content)['outputs']

input(
  name:    'enabled'
  value:   true
  profile: 'aws-rds'
)

input(
  name:    'is_aurora'
  value:   false
  profile: 'aws-rds'
)

input(
  name:    'db_instance_identifier',
  value:   'tftest'
  profile: 'aws-rds'
)

input(
  name:    'db_name',
  value:   outputs['database_name']
  profile: 'aws-rds'
)

input(
  name:    'engine',
  value:   'postgres'
  profile: 'aws-rds'
)

input(
  name:    'engine_version'
  value:   '9.6.9'
  profile: 'aws-rds'
)

include_controls 'aws-rds'
