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

# Change the hostname
execute 'Set hostname' do
  command "hostnamectl set-hostname #{node.name}"
end

execute 'Change node hostname in sysconfig' do
  command "echo \"HOSTNAME=#{node.name}\" >>  /etc/sysconfig/network"
end

# Edit cloud config to disable hostname setting
execute 'Prevent cloud config from setting hostname' do
  command "sed -i 's/- set_hostname/#- set_hostname/' #{node['network']['cloud_config_file']}"
end
# Edit cloud config to disable hostname update
execute 'Prevent cloud config from updating hostname' do
  command "sed -i 's/- update_hostname/#- update_hostname/' #{node['network']['cloud_config_file']}"
end

# change peer dns settings and add new DNS
template node['network']['eth0_config_path'] do
  source 'ifcfg-eth0.erb'
  variables ({ 
    :dns => dns
  })
  notifies :restart, 'service[network]', :immediately
end


