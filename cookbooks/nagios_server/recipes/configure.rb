#
# Cookbook Name:: nagios_server
# Recipe:: configure
#

# Get the Env databag
environment = data_bag_item('nagios','environment')
nagios_server_ip = environment['nagios_server_ip']


# Edit /etc/xinetd.d/nrpe
template "/etc/xinetd.d/nrpe" do
  source 'nrpe.erb'
  variables ({
    :nagios_server_ip => nagios_server_ip
  })
end

# xinetd restart
service "xinetd" do
  action :restart
end

# Edit /usr/local/nagios/etc/nagios.cfg
template "/usr/local/nagios/etc/nagios.cfg" do
  source 'nagios.cfg.erb'
end

# Create Dir/usr/local/nagios/etc/servers
directory '/usr/local/nagios/etc/servers' do
  action :create
end

# Edit /usr/local/nagios/etc/objects/contacts.cfg
template "/usr/local/nagios/etc/objects/contacts.cfg" do
  source 'contacts.cfg.erb'
end

# Edit /usr/local/nagios/etc/objects/commands.cfg
template "/usr/local/nagios/etc/objects/commands.cfg" do
  source 'commands.cfg.erb'
end

# add http password
template "/usr/local/nagios/etc/htpasswd.users" do
  source 'htpasswd.users.erb'
end

# nagios restart
service "nagios" do
  action :restart
end

# httpd restart
service "httpd" do
  action :restart
end

