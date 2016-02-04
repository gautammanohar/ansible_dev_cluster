#
# Cookbook Name:: common
# Recipe:: zabbix_agent
#

# create the zabbix agent group
group 'zabbixagent' do
  action :create
end

# create the zabbix user
user node['zabbix_agent']['user'] do
  group node['zabbix_agent']['group']
  home node['zabbix_agent']['user_home']
  shell '/bin/bash'
end

# Download zabbix tarball
execute 'Download Zabbix Agent Tarball' do
  command "wget -q #{node['zabbix_agent']['tarball_url']} -P #{node['zabbix_agent']['user_home']}"
  creates "#{node['zabbix_agent']['user_home']}/#{node['zabbix_agent']['tarball_name']}"
  action :run
end

# Extract Zabbix Agent packages
execute 'Extract Zabbix Agent Package' do
  command "tar -xvzf #{node['zabbix_agent']['tarball_name']}"
  cwd node['zabbix_agent']['user_home']
  not_if { File.exists?("#{node['zabbix_agent']['user_home']}/#{node['zabbix_agent']['zabbix_folder']}/#{node['zabbix_agent']['mysql_schema_path']}") }
end

# Configure Zabbix Agent
execute 'Configure Zabbix Agent' do
  command './configure --enable-agent'
  cwd "#{node['zabbix_agent']['user_home']}/#{node['zabbix_agent']['zabbix_folder']}"
  not_if { File.exists?("#{node['zabbix_agent']['user_home']}/#{node['zabbix_agent']['zabbix_folder']}.txt")}
end

# Install
execute 'Make install zabbix agent' do
  command 'make install'
  cwd "#{node['zabbix_agent']['user_home']}/#{node['zabbix_agent']['zabbix_folder']}"
  not_if { File.exists?("#{node['zabbix_agent']['user_home']}/#{node['zabbix_agent']['zabbix_folder']}.txt")}
end

# Store the zabbix Agent version file.
execute 'Store the Zabbix Agent version' do
  command "touch #{node['zabbix_agent']['user_home']}/#{node['zabbix_agent']['zabbix_folder']}.txt"
  creates "#{node['zabbix_agent']['user_home']}/#{node['zabbix_agent']['zabbix_folder']}.txt" 
  action :run
end

# Configure zabbix_agent.conf
# Get the databag
server = data_bag_item('zabbix','server')
zabbix_server_ip = server['server_ip']
template "/usr/local/etc/zabbix_agentd.conf" do
  source 'zabbix_agentd.conf.erb'
  variables ({
    :zabbix_server_ip => zabbix_server_ip,
  })

end

# Add the init script for the agent
template "/etc/init.d/zabbixagent" do
  source 'zabbix_agentd.erb'
  mode '0755'
end

# Issue zabbix agent restart
service "zabbixagent" do
  action :restart
end





