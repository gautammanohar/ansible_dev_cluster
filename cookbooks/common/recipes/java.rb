#
# Cookbook Name:: common
# Recipe:: java
#

execute 'download Oracle Java 8 JRE RPM' do
  command "wget --no-cookies --no-check-certificate --header \"#{node['jre']['download_header']}\" \"#{node['jre']['download_url']}\" -P /tmp/"
  creates "/tmp/#{node['jre']['package']}"
  action :run
end

package node['jre']['package'] do
  source "/tmp/#{node['jre']['package']}"
  action :install
  not_if "rpm -qa | grep 'jre1.8.0'"
end

execute 'download Oracle Java 8 JDK RPM' do
  command "wget --no-cookies --no-check-certificate --header \"#{node['jdk']['download_header']}\" \"#{node['jdk']['download_url']}\" -P /tmp/"
  creates "/tmp/#{node['jdk']['package']}"
  action :run
end

package node['jdk']['package'] do
  source "/tmp/#{node['jdk']['package']}"
  action :install
  not_if "rpm -qa | grep 'jdk1.8.0'"
end

