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
