#
# Cookbook Name:: mongo_server
# Recipe:: seed
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Download schema seed file to filesystem.
execute 'Download Mongo Test dataset' do
  command "wget #{node['mongodb']['seed_file_location']} -O #{node['mongodb']['seed_file']}"
  creates "#{node['mongodb']['seed_file']}"
  action :run
end


# import/ seed the mongo db
execute 'import mongo seed data' do
  command "mongoimport --db #{node['mongodb']['dbname']} --collection #{node['mongodb']['collection']} --drop --file #{node['mongodb']['seed_file']}"
end
