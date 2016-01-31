#
# Cookbook Name:: zabbix_server
# Recipe:: db
#
# Install the mysql/postgres server

# Configure the mysql2 Ruby gem.
mysql2_chef_gem 'default' do
  action :install
end

# Configure the MySQL client.
mysql_client 'default' do
  action :create
end

# Configure the MySQL service.
mysql_service 'default' do
  initial_root_password node['zabbix_server']['database']['root_pass']
  action [:create, :start]
end

# Add our custom config
template "/etc/mysql-default/my.cnf" do
  source 'my.cnf.erb'
  notifies :restart, 'mysql_service[default]'
end


# Create the database instance.
mysql_database node['zabbix_server']['database']['dbname'] do
  connection(
    :host => node['zabbix_server']['database']['host'],
    :username => node['zabbix_server']['database']['superuser'],
    :password => node['zabbix_server']['database']['root_pass']
  )
  action :create
end

# Add a database user.
mysql_database_user node['zabbix_server']['database']['zabbix_user'] do
  connection(
    :host => node['zabbix_server']['database']['host'],
    :username => node['zabbix_server']['database']['superuser'],
    :password => node['zabbix_server']['database']['root_pass']
  )
  password node['zabbix_server']['database']['zabbix_pass']
  database_name node['zabbix_server']['database']['dbname']
  host node['zabbix_server']['database']['remote_host']
  action [:create, :grant]
end

