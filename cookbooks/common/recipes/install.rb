#
# Cookbook Name:: common
# Recipe:: install
#

# Enable RHEL optional repo
execute 'Enable optional repo' do
  command 'yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional'
end


# Install Bind-Utils
package node['common']['bind_utils'] do
  action :install
end

# install wget
package 'wget' do
  action :install
end

# install epel-realease
package 'epel-release' do
  action :install
end

# Install yum Development package
execute 'Install Devel Packages' do
  command 'yum -y groupinstall "Development tools"'
end

