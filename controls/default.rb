#
# inspec_profile::aws-rds
# controls::enabled
#
# author:cloudsquad@fxinnovation.com
# description: Default controls for aws-rds
#

#####
# Input handling
#####

enabled          = input('enabled')
is_aurora        = input('is_aurora')
db_identifier    = if is_aurora
                     input('db_cluster_identifier')
                   else
                     input('db_instance_identifier')
                   end
allocated_storage = input('allocated_storage')
db_instance_class = input('db_instance_class')
db_instance_port  = input('db_instance_port')
db_name           = input('db_name')
engine            = input('engine')
engine_version    = input('engine_version')

#####
# Controls
#####

control 'aws-rds' do
  impact 1.0
  title  'Check the AWS Relational Database Service'
  tag    'aws'
  tag    'rds'

  # RDS Instance
  describe aws_rds_instance(db_identifier) do
    if enabled && !is_aurora
      it { should exist }
      its('allocated_storage') { should be    allocated_storage }
      its('db_instance_class') { should be    db_instance_class }
      its('db_instance_port')  { should be    db_instance_port }
      its('db_name')           { should be    db_name }
      its('engine')            { should be    engine }
      its('engine_version')    { should match engine_version }
    else
      it { should_not exist }
    end
  end

  # RDS Cluster
  describe aws_rds_cluster(db_identifier) do
    if enabled && is_aurora
      it { should exist }
      its('allocated_storage') { should be    allocated_storage }
      its('database_name')     { should be    db_name }
      its('engine')            { should be    engine }
      its('engine_version')    { should match engine_version }
    else
      it { should_not exist }
    end
  end
end
