#
# Cookbook Name:: cassandra_server
# Recipe:: seed
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Write schema seed file to filesystem.
#cookbook_file node['cassandra_server']['seed_file'] do
#  source 'demo_schema.cql'
#  owner 'root'
#  group 'root'
#  mode '0600'
#end

# Get the Cassandra databag
cluster = data_bag_item('cassandra','cluster')
seed = cluster['seed']


# import/ seed the demo schema
execute 'import cassandra seed data' do
  command "/usr/bin/cqlsh #{node['ipaddress']} -e \"source '#{node['cassandra_server']['seed_file']}'\""
  only_if { node['ipaddress'] == seed }
end


