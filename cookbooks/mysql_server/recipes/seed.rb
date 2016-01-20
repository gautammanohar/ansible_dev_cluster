#
# Cookbook Name:: mysql_server
# Recipe:: seed
#
# Copyright (c) 2016 The Authors, All Rights Reserved.




# Load the encrypted data bag item that holds the database user's password.
password_secret = Chef::EncryptedDataBagItem.load_secret(node['default']['secret_path'])
root_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'mysql_root_password', password_secret)
user_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'db_admin_password', password_secret)


# Add a database user.
mysql_database_user node['mysql_server']['database']['app']['username'] do
  connection(
    :host => node['mysql_server']['database']['host'],
    :username => node['mysql_server']['database']['username'],
    :password => root_password_data_bag_item['password']
  )
  password user_password_data_bag_item['password']
  database_name node['mysql_server']['database']['dbname']
  host node['mysql_server']['database']['remote_host']
  action [:create, :grant]
end

# Write schema seed file to filesystem.
cookbook_file node['mysql_server']['database']['seed_file'] do
  source 'seed-db.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

# Seed the database with a table and test data.
execute 'initialize database' do
  command "mysql -h #{node['mysql_server']['database']['host']} -u #{node['mysql_server']['database']['app']['username']} -p#{user_password_data_bag_item['password']} -D #{node['mysql_server']['database']['dbname']} < #{node['mysql_server']['database']['seed_file']}"
  not_if  "mysql -h #{node['mysql_server']['database']['host']} -u #{node['mysql_server']['database']['app']['username']} -p#{user_password_data_bag_item['password']} -D #{node['mysql_server']['database']['dbname']} -e 'describe data_table;'"
end
