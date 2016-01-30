#
# Cookbook Name:: kafka_server
# Recipe:: install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Download kafka tarball
execute 'download apache kafka' do
  command "wget #{node['kafka_server']['tarball']} -P /tmp/"
  creates node['kafka_server']['tarball_path']
  action :run
  not_if { File.exists?("#{node['kafka_server']['tarball_path']}") }
end

# Extract Apache kafka packages
execute 'extract apache kafka' do
  command "tar -xzf #{node['kafka_server']['tarball_version']} -C /opt/"
  cwd '/tmp/'
  not_if { File.exists?("/opt/#{node['kafka_server']['tarball_folder']}/bin/kafka-configs.sh") }
end

# Create the data dirs


# Get the Cluster databag
cluster = data_bag_item('kafka','cluster')
brokers = cluster['brokers']
broker_id = brokers[node['ipaddress']]['id']


# Add the zookeeper cluster config
template node['kafka_server']['zookeeper_config_path'] do
  source 'zookeeper.properties.erb'
  variables ({
    :brokers => brokers
  })
end

# Add the zookeeper my id file


# Start Zoo keeper
execute 'start zookeeper' do
  command "/opt/#{node['kafka_server']['tarball_folder']}/bin/zookeeper-server-start.sh -daemon config/zookeeper.properties"
  cwd '/opt/kafka_2.11-0.9.0.0/'
  action :run
end


# Add the kafka cluster config
template node['kafka_server']['config_path'] do
  source 'server.properties.erb'
  variables ({
    :brokers => brokers,
    :broker_id => broker_id
  })
end

# Start Kafka server
execute 'start kafka' do
  command "sleep 15; /opt/#{node['kafka_server']['tarball_folder']}/bin/kafka-server-start.sh -daemon config/server.properties"
  cwd "/opt/#{node['kafka_server']['tarball_folder']}/"
  action :run
end
