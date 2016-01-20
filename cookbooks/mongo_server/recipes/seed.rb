#
# Cookbook Name:: mongo_server
# Recipe:: seed
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Write schema seed file to filesystem.
cookbook_file node['mongodb']['seed_file'] do
  source 'seed-db.json'
  owner 'root'
  group 'root'
  mode '0600'
end


# import/ seed the mongo db
execute 'import mongo seed data' do
  command "mongoimport --db #{node['mongodb']['dbname']} --collection #{node['mongodb']['collection']} --drop --file #{node['mongodb']['seed_file']}"
end
