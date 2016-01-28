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

# start the cassandra service
service "cassandra" do 
  supports :status => true, :restart => true, :reload => true 
  action [ :enable, :start ]
end
