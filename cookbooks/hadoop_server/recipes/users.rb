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

# add the env vars
template "#{node['hadoop_server']['user_home']}/.bashrc" do
  source 'bashrc.erb'
  owner node['hadoop_server']['user']
  group node['hadoop_server']['group']
end

# source the env vars
execute 'Source the env variables' do
  command "exec bash"
  user node['hadoop_server']['user']
  group node['hadoop_server']['group']
end

# Add .ssh dir
directory "#{node['hadoop_server']['user_home']}/.ssh" do
  owner node['hadoop_server']['user']
  group node['hadoop_server']['group']
  mode '0755'
  action :create
end

# Get the Cluster databag
cluster = data_bag_item('hadoop','cluster')
namenode = cluster['name_node']

# Add id_rsa
template "#{node['hadoop_server']['user_home']}/.ssh/id_rsa" do
  source 'id_rsa.erb'
  mode '0700'
  only_if { node.name == namenode } 
end

# Add id_rsa.pub
template "#{node['hadoop_server']['user_home']}/.ssh/id_rsa.pub" do
  source 'id_rsa.pub.erb'
  mode '0700'
  only_if { node.name == namenode } 
end

# Add namenode key to authorized hosts
template "#{node['hadoop_server']['user_home']}/.ssh/authorized_keys" do
  source 'authorized_keys.erb'
  mode '0755'
  only_if { node.name != namenode } 
end

