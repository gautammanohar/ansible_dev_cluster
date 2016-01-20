#
# Cookbook Name:: mongo_server
# Recipe:: install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Add the required repository
yum_repository 'mongodb' do
  description 'mongodb RPM Repository'
  baseurl "https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/"
  action :create
  gpgcheck false
  enabled true
end

# install
package node['mongodb']['package_name'] do
  options '--nogpgcheck'
  action :install
end

# add our custom mongo.conf
template "/etc/mongod.conf" do
  source 'mongod.conf.erb'
end

# start the mongo service
service "mongod" do 
  action :start
end
