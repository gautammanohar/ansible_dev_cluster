#
# Cookbook Name:: nagios_server
# Recipe:: hosts
#

# Get the Env databag
environment = data_bag_item('nagios','environment')
hosts = environment['hosts']

# Add the new host files
hosts.each do |ip,hostname|
  template "/usr/local/nagios/etc/servers/#{hostname}.cfg" do
    source 'host.erb'
    variables ({
      :hostname => hostname,
      :host_ip => ip
    })
  end
end

# nagios restart
service "nagios" do
  action :restart
end

