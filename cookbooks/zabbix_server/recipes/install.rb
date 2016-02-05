#
# Cookbook Name:: zabbix_server
# Recipe:: install
#


node['zabbix_server']['base_packages'].each do |p|
  package p do
    action :install
  end
end

# install yum-utils 
package 'yum-utils' do
  action :install
end

# Enable RHEL optional repo
execute 'Enable optional repo' do
  command 'yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional'
end

# install 
package 'php-mbstring' do
  action :install
end

# install 
package 'php-bcmath' do
  action :install
end

# Configure Zabbix server
execute 'Configure Zabbix server' do
  command './configure --enable-server --enable-agent --with-mysql --enable-ipv6 --with-net-snmp --with-libcurl --with-libxml2'
  cwd "#{node['zabbix_server']['user_home']}/#{node['zabbix_server']['zabbix_folder']}"
  not_if { File.exists?("#{node['zabbix_server']['user_home']}/#{node['zabbix_server']['zabbix_folder']}.txt")}
end

# Install
execute 'make install' do
  command 'make install'
  cwd "#{node['zabbix_server']['user_home']}/#{node['zabbix_server']['zabbix_folder']}"
  not_if { File.exists?("#{node['zabbix_server']['user_home']}/#{node['zabbix_server']['zabbix_folder']}.txt")}
end

# Store the zabbix version file.
execute 'Store the Zabbix version' do
  command "touch #{node['zabbix_server']['user_home']}/#{node['zabbix_server']['zabbix_folder']}.txt"
  creates "#{node['zabbix_server']['user_home']}/#{node['zabbix_server']['zabbix_folder']}.txt" 
  action :run
end

# At the init script
template "/etc/init.d/zabbix" do
  source 'zabbix_server.erb'
  mode '0755'
end






