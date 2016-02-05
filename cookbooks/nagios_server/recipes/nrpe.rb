#
# Cookbook Name:: nagios_server
# Recipe:: nrpe
#
# Download nrpe tarball
execute 'Download Nrpe Tarball' do
  command "wget -q #{node['nagios_server']['nrpe_url']} -P #{node['nagios_server']['user_home']}"
  creates "#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_tarball_name']}"
  action :run
end

# Extract Nrpe packages
execute 'Extract Nrpe Package' do
  command "tar -xvzf #{node['nagios_server']['nrpe_tarball_name']}"
  cwd node['nagios_server']['user_home']
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}/configure") }
end


# Configure Nrpe
execute 'Configure Nrpe' do
  command './configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu'
  cwd "#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}"
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}.txt")}
end

# Make all
execute 'make all' do
  command 'make all'
  cwd "#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}"
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}.txt")}
end

# Make Install
execute 'make install' do
  command 'make install'
  cwd "#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}"
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}.txt")}
end

# Make Install Xinetd
execute 'make install-xinetd' do
  command 'make install-xinetd'
  cwd "#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}"
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}.txt")}
end

# Make Install daemon-config
execute 'make install-daemon-config' do
  command 'make install-daemon-config'
  cwd "#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}"
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}.txt")}
end

# Store the nrpe version file.
execute 'Store the Nrpe version' do
  command "touch #{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}.txt"
  creates "#{node['nagios_server']['user_home']}/#{node['nagios_server']['nrpe_folder']}.txt" 
  action :run
end


