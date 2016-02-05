#
# Cookbook Name:: common
# Recipe:: nagios_client
#


# Download epel-release
execute 'Download Epel release' do
  command "wget -q #{node['common']['epel_url']} -P /tmp"
  creates "/tmp/#{node['common']['epel_rpm_name']}"
  action :run
end

# Install epel-release
execute 'Install epel-release' do
  command "rpm -ivh #{node['common']['epel_rpm_name']}"
  cwd "/tmp"
  not_if "rpm -qa | grep 'epel-release'"
end

# install nrpe
package 'nrpe' do
  action :install
end

# install nagios-plugins-all 
package 'nagios-plugins-all' do
  action :install
end

# Get the Env databag
environment = data_bag_item('nagios','environment')
nagios_server_ip = environment['nagios_server_ip']

# Edit /etc/nagios/nrpe.cfg
template "/etc/nagios/nrpe.cfg" do
  source 'client_nrpe.cfg.erb'
  variables ({
    :nagios_server_ip => nagios_server_ip
  })
end

# nrpe restart
service "nrpe" do
  action :restart
end


