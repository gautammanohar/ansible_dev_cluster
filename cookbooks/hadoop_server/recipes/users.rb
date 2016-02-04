#
# Cookbook Name:: hadoop_server
# Recipe:: users
#

# create the hadoop group
group 'hadoop' do
  action :create
end

# create the hadoop user
user node['hadoop_server']['user'] do
  group node['hadoop_server']['group']
  home node['hadoop_server']['user_home']
  shell '/bin/bash'
end

# source the env vars

