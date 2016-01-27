#
# Cookbook Name:: dns_server
# Recipe:: configure
#

# Get DNS data from databag
dns = data_bag_item('network','dns')

# Add our custom config : named.conf
template node['dns']['named_conf_path'] do
  source 'named.conf.erb'
end

# Add the local conf : named.conf.local
template node['dns']['named_conf_local_path'] do
  source 'named.conf.local.erb'
  variables ({ 
    :dns => dns
  })
end

# Create the zones directory
directory node['dns']['zones_directory'] do
  owner 'named'
  group 'named'
  mode '0755'
  action :create
end

# Add the forward zone file
template node['dns']['zone_file_path'] do
  source 'forward_zone_file.erb'
  variables ({ 
    :dns => dns
  })
end

# Add the reverse zone file
template node['dns']['reverse_zone_file_path'] do
  source 'reverse_zone_file.erb'
  variables ({ 
    :dns => dns
  })
end

# Start Service
service "named" do
  action :start
end

# Start on boot
service "named" do
  action :enable
end


