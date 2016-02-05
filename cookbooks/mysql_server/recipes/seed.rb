#
# Cookbook Name:: mysql_server
# Recipe:: seed
#
# Copyright (c) 2016 The Authors, All Rights Reserved.




# Load the encrypted data bag item that holds the database user's password.
#password_secret = Chef::EncryptedDataBagItem.load_secret(node['default']['secret_path'])
#root_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'mysql_root_password', password_secret)
#user_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'db_admin_password', password_secret)


# Add a database user (localhost).
mysql_database_user node['mysql_server']['database']['app']['username'] do
  connection(
    :host => node['mysql_server']['database']['host'],
    :username => node['mysql_server']['database']['username'],
    :password => node['mysql_server']['database']['root_pass'],
  )
  password node['mysql_server']['database']['admin_pass']
  database_name node['mysql_server']['database']['dbname']
  host node['mysql_server']['database']['remote_host']
  action [:create, :grant]
end


# Add a database user (devuser).
mysql_database_user node['mysql_server']['database']['dev_user'] do
  connection(
    :host => node['mysql_server']['database']['host'],
    :username => node['mysql_server']['database']['username'],
    :password => node['mysql_server']['database']['root_pass'],
  )
  password node['mysql_server']['database']['dev_pass']
  database_name node['mysql_server']['database']['dbname']
  host '%'
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
  command "mysql -h #{node['mysql_server']['database']['host']} -u #{node['mysql_server']['database']['app']['username']} -p#{node['mysql_server']['database']['admin_pass']} -D #{node['mysql_server']['database']['dbname']} < #{node['mysql_server']['database']['seed_file']}"
  not_if  "mysql -h #{node['mysql_server']['database']['host']} -u #{node['mysql_server']['database']['app']['username']} -p#{node['mysql_server']['database']['admin_pass']} -D #{node['mysql_server']['database']['dbname']} -e 'describe data_table;'"
end
