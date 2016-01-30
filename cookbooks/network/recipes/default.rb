#
# Cookbook Name:: network
# Recipe:: default
#

# Edit the ifcfg-eth0 settings
dns = data_bag_item('network','dns')

# define the network service
service "network" do
  action :nothing
end

# change the hostname
execute 'Change node hostname' do
  command "hostname #{node.name}"
end

execute 'Change node hostname' do
  command "echo \"HOSTNAME=#{node.name}\" >>  /etc/sysconfig/network"
end

# change peer dns settings and add new DNS
template node['network']['eth0_config_path'] do
  source 'ifcfg-eth0.erb'
  variables ({ 
    :dns => dns
  })
  notifies :restart, 'service[network]', :immediately
end


