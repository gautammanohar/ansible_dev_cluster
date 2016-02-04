#
# Cookbook Name:: zabbix_server
# Recipe:: interface
#

# define the httpd service
service "httpd" do
  action :nothing
end

# configure zabbix_server.conf
template "/usr/local/etc/zabbix_server.conf" do
  source 'zabbix_server.conf.erb'
end

# configure php.ini
template "/etc/php.ini" do
  source 'php.ini.erb'
  notifies :restart, 'service[httpd]'
end

# move the front end files to the right location
execute 'Move zabbix frontend to HTTPD root' do
  command "cp -a #{node['zabbix_server']['user_home']}/#{node['zabbix_server']['zabbix_folder']}/#{node['zabbix_server']['frontend_source']}/* #{node['zabbix_server']['httpd_root']}/"
  not_if { File.exists?("#{node['zabbix_server']['httpd_root']}/host_discovery.php")}
end

# Place the zabbix frontend conf file
template "#{node['zabbix_server']['httpd_root']}/conf/zabbix.conf.php" do
  source 'zabbix.conf.php.erb'
end


# Issue zabbix server restart
service "zabbix" do
  action :restart
end

  

