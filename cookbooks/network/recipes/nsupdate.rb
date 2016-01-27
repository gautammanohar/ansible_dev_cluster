#
# Cookbook Name:: network
# Recipe:: nsupdate
#

# Get DNS data from databag
dns = data_bag_item('network','dns')

# Add the key file
template node['network']['dns_key_path'] do
  source 'dns.key.erb'
  variables ({ 
    :dns => dns
  })
end

# Add the update file
template node['network']['update_file_path'] do
  source 'update.txt.erb'
  variables ({ 
    :dns => dns
  })
end

# execute the nsupdate command
execute 'Update DNS server' do
  command "nsupdate -k #{node['network']['dns_key_path']} -v #{node['network']['update_file_path']}"
  action :run
  retries 3
  retry_delay 10
end

