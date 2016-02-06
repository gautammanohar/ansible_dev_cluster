#
# Cookbook Name:: cassandra_server
# Recipe:: install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


# Add the required repository
yum_repository 'datastax' do
  description 'DataStax Repo for Apache Cassandra'
  baseurl "http://rpm.datastax.com/community"
  action :create
  gpgcheck false
  enabled true
end

# install
package 'dsc30' do
  action :install
  not_if "rpm -qa | grep 'cassandra30-3.0.2-1.noarch'"
end


# Get the Cassandra databag
cluster = data_bag_item('cassandra','cluster')
seed = cluster['seed']
tokens = cluster['tokens']
token = tokens[node['ipaddress']]
cluster_name = cluster['cluster_name']
snitch = cluster['snitch']
# Add the cluster config
template '/etc/cassandra/conf/cassandra.yaml' do
  source 'cassandra.yaml.erb'
  variables ({
    :seed => seed,
    :token => token,
    :cluster_name => cluster_name,
    :snitch => snitch  
  })
end


# start the cassandra service
service "cassandra" do 
  supports :status => true, :restart => true, :reload => true 
  action [ :enable, :start ]
end


# Write schema seed file to filesystem.
cookbook_file node['cassandra_server']['seed_file'] do
  source 'demo_schema.cql'
  owner 'root'
  group 'root'
  mode '0777'
  only_if { node['ipaddress'] == seed } 
end
