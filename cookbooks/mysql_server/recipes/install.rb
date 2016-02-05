#
# Cookbook Name:: mysql_server
# Recipe:: install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Configure the mysql2 Ruby gem.
mysql2_chef_gem 'default' do
  action :install
end

# Configure the MySQL client.
mysql_client 'default' do
  action :create
end

# Load the secrets file and the encrypted data bag item that holds the root password.
# password_secret = Chef::EncryptedDataBagItem.load_secret(node['default']['secret_path'])
# root_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'mysql_root_password', password_secret)

# Configure the MySQL service.
mysql_service 'default' do
  initial_root_password node['mysql_server']['database']['root_pass']
  action [:create, :start]
end

# Add our custom config
template "/etc/mysql-default/my.cnf" do
  source 'my.cnf.erb'
  notifies :restart, 'mysql_service[default]'
end


# Create the database instance.
mysql_database node['mysql_server']['database']['dbname'] do
  connection(
    :host => node['mysql_server']['database']['host'],
    :username => node['mysql_server']['database']['username'],
    :password => node['mysql_server']['database']['root_pass'],
  )
  action :create
end



