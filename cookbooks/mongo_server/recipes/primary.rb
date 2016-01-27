#
# Cookbook Name:: mongo_server
# Recipe:: primary
#

# Get the mongo nodes from the databag
replset = data_bag_item('mongo','replset')
hostnames = replset['hostnames']

# Add the replset config
template node['mongodb']['init_replset_file'] do
  source 'init_replset.js.erb'
  variables ({
    :hostnames => hostnames
  })
end

# initiate the replset
execute 'Initiate replset' do
  command "mongo --port 27017 #{['mongodb']['init_replset_file']}"
end



