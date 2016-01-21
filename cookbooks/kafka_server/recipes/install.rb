#
# Cookbook Name:: kafka_server
# Recipe:: install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# install wget
package 'wget' do
  action :install
end


execute 'download Oracle Java 8 JRE RPM' do
  command 'wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jre-8u60-linux-x64.rpm" -P /tmp/'
  creates '/tmp/jre-8u60-linux-x64.rpm'
  action :run
end

package "jre-8u60-linux-x64.rpm" do
  source "/tmp/jre-8u60-linux-x64.rpm"
  action :install
  not_if "rpm -qa | grep 'jre1.8.0'"
end

execute 'download Oracle Java 8 JDK RPM' do
  command 'wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm" -P /tmp/'
  creates '/tmp/jdk-8u60-linux-x64.rpm'
  action :run
end

package "jdk-8u60-linux-x64.rpm" do
  source "/tmp/jdk-8u60-linux-x64.rpm"
  action :install
  not_if "rpm -qa | grep 'jdk1.8.0'"
end

# Download kafka tarball
execute 'download apache kafka' do
  command 'wget http://www.us.apache.org/dist/kafka/0.9.0.0/kafka_2.11-0.9.0.0.tgz -P /tmp/'
  creates '/tmp/kafka_2.11-0.9.0.0.tgz'
  action :run
end

# Extract Apache kafka packages
execute 'extract apache kafka' do
  command 'tar -xzf kafka_2.11-0.9.0.0.tgz -C /opt/'
  cwd '/tmp/'
  not_if { File.exists?("/opt/kafka_2.11-0.9.0.0/bin/kafka-configs.sh") }
end

# Start Zoo keeper
execute 'start zookeeper' do
  command '/opt/kafka_2.11-0.9.0.0/bin/zookeeper-server-start.sh -daemon config/zookeeper.properties'
  cwd '/opt/kafka_2.11-0.9.0.0/'
  action :run
end

# Start Kafka server
execute 'start kafka' do
  command '/opt/kafka_2.11-0.9.0.0/bin/kafka-server-start.sh -daemon config/server.properties'
  cwd '/opt/kafka_2.11-0.9.0.0/'
  action :run
end
