#
# Cookbook Name:: nagios_server
# Recipe:: user
#

# create the nagios group
group node['nagios_server']['group'] do
  action :create
end

# create the nagios user
user node['nagios_server']['user'] do
  group node['nagios_server']['group']
  home node['nagios_server']['user_home']
  shell '/bin/bash'
end

