#
# Cookbook Name:: zabbix_server
# Recipe:: download
#
# Download the tarball, extract and import mysql data/schema

# Download zabbix tarball
execute 'Download Zabbix Tarball' do
  command "wget -q #{node['zabbix_server']['tarball_url']} -P #{node['zabbix_server']['user_home']}"
  creates "#{node['zabbix_server']['user_home']}/#{node['zabbix_server']['tarball_name']}"
  action :run
end

# Extract Zabbix packages
execute 'Extract Zabbix Package' do
  command "tar -xvzf #{node['zabbix_server']['tarball_name']}"
  cwd node['zabbix_server']['user_home']
  not_if { File.exists?("#{node['zabbix_server']['user_home']}/#{node['zabbix_server']['zabbix_folder']}/#{node['zabbix_server']['mysql_schema_path']}") }
end

# Import the zabbix db schema and data
execute 'initialize database' do
  command "mysql -h #{node['zabbix_server']['database']['host']} -u#{node['zabbix_server']['database']['zabbix_user']} -p#{node['zabbix_server']['database']['zabbix_pass']} -D #{node['zabbix_server']['database']['dbname']} < #{node['zabbix_server']['user_home']}/#{node['zabbix_server']['zabbix_folder']}/#{node['zabbix_server']['mysql_schema_path']}"
  not_if  "mysql -h #{node['zabbix_server']['database']['host']} -u#{node['zabbix_server']['database']['zabbix_user']} -p#{node['zabbix_server']['database']['zabbix_pass']} -D #{node['zabbix_server']['database']['dbname']} -e 'describe #{node['zabbix_server']['database']['check_table']};'"
end


