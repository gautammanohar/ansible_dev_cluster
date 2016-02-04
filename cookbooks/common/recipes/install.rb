#
# Cookbook Name:: common
# Recipe:: install
#

# Install Bind-Utils
package node['common']['bind_utils'] do
  action :install
end

# install wget
package 'wget' do
  action :install
end

# Install yum Development package
execute 'Install Devel Packages' do
  command 'yum -y groupinstall "Development tools"'
end

