#
# Cookbook Name:: zabbix_server
# Recipe:: user
#

# create the zabbix group
group 'zabbix' do
  action :create
end

# create the zabbix user
user node['zabbix_server']['user'] do
  group node['zabbix_server']['group']
  home node['zabbix_server']['user_home']
  shell '/bin/bash'
end

