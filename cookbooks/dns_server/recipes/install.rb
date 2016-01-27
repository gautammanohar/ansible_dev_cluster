#
# Cookbook Name:: dns_server
# Recipe:: install


# Install Bind
package node['dns']['bind'] do
  action :install
end



