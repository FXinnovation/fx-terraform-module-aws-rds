#
# profile::aws_rds_instance
# controls::default
#
# description: Controls for an AWS RDS Instance.
# authors: Christophe van de Kerchove
#

control 'aws_rds_instance_existance' do
  impact 1
  title  'AWS RDS instance existance'
  desc   'Validates the existence of an AWS RDS instance.'
  tag    'aws'
  tag    'rds'

  only_if('input says it should exist') do
    input('aws_rds_enabled') == true
  end

  describe aws_rds_instance(db_instance_identifier) do
    it { should exist }
  end
end

%w(
  allocated_storage
  associated_roles
  auto_minor_version_upgrade
  availability_zone
  backup_retention_period
  ca_certificate_identifier
  character_set_name
  copy_tags_to_snapshot
  db_cluster_dentifier
  db_instance_arn
  db_instance_class
  db_instance_port
  db_instance_status
  db_name
  db_parameter_groups
  db_security_groups
  db_subnet_group
  deletion_protection
  enabled_cloudwatch_logs_exports
  endpoint
  engine
  engine_version
  enhanced_monitoring_resource_arn
  iam_database_authentication_enabled
  iops
  kms_key_id
  license_endpoint
  listener_endpoint
  master_username
  max_allocated_storage
  monitoring_interval
  monitoring_role_arn
  multi_az
  option_group_memberships
  performance_insights_enabled
  performance_insights_retention_period
  preferred_backup_window
  preferred_maintenance_window
  publicly_accessible
  secondary_availability_zone
  storage_encrypted
  storage_type
  timezone
  vpc_security_groups
).each do |attribute_name|
  # Declaring input
  input(
    name:        attribute_name,
    value:       null,
    description: "Expected value of the #{attribute_name} attribute of the AWS RDS instance.",
    type:        'Any',
    required:    false,
    priority:    0,
    profile:     'aws_rds_instance'
  )

  # Control on input
  control "aws_rds_instance_#{attribute_name}" do
    impact 1
    title  "AWS RDS instance #{attribute_name} value check"
    desc   "Validates the value the #{attribute_name} attribute of an AWS RDS instance."
    tag    'aws'
    tag    'rds'
    tag    attribute_name

    only_if("input says it should exist and input of #{attribute_name} is not null") do
      input('enabled') == true && input(attribute_name) != null
    end

    describe aws_rds_instance(db_instance_identifier) do
      its(attribute_name) { should eq input(attribute_name) }
    end
  end
end
