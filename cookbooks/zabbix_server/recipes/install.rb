#
# Cookbook Name:: zabbix_server
# Recipe:: install
#

# Extract Zabbix packages
execute 'Install Devel Packages' do
  command 'yum -y groupinstall "Development tools"'
end

# install mysql-devel
package 'mysql-devel' do
  action :install
end

# install libxml2-devel 
package 'libxml2-devel' do
  action :install
end

# install net-snmp-devel
package 'net-snmp-devel' do
  action :install
end

# install libcurl-devel
package 'libcurl-devel' do
  action :install
end

# install httpd
package 'httpd' do
  action :install
end

# install 
package 'php' do
  action :install
end

# install 
package 'php-mysql' do
  action :install
end

# install php-xmlwriter
package 'php-xmlwriter' do
  action :install
end

# install php-xmlreader
package 'php-xmlreader' do
  action :install
end

# install php-gd 
package 'php-gd' do
  action :install
end

# install yum-utils 
package 'yum-utils' do
  action :install
end

# Enable RHEL optional repo
execute 'Enable option repo' do
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
end

# Install
execute 'make install' do
  command 'make install'
  cwd "#{node['zabbix_server']['user_home']}/#{node['zabbix_server']['zabbix_folder']}"
end




