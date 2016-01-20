#
# Cookbook Name:: cassandra_server
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
end

execute 'download Oracle Java 8 JDK RPM' do
  command 'wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm" -P /tmp/'
  creates '/tmp/jdk-8u60-linux-x64.rpm'
  action :run
end

package "jdk-8u60-linux-x64.rpm" do
  source "/tmp/jdk-8u60-linux-x64.rpm"
  action :install
end

# Add the required repository
yum_repository 'datastax' do
  description 'DataStax Repo for Apache Cassandra'
  baseurl "http://rpm.datastax.com/community"
  action :create
  gpgcheck false
  enabled true
end

# install
package 'dsc30' do
  action :install
end

# start the cassandra service
service "cassandra" do 
  action :start
end
