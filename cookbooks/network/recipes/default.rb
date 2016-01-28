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

template node['network']['eth0_config_path'] do
  source 'ifcfg-eth0.erb'
  variables ({ 
    :dns => dns
  })
  notifies :restart, 'service[network]', :immediately
end


