#
# Cookbook Name:: nagios_server
# Recipe:: plugins
#

# Download plugin tarball
execute 'Download Plugin Tarball' do
  command "wget -q #{node['nagios_server']['plugin_url']} -P #{node['nagios_server']['user_home']}"
  creates "#{node['nagios_server']['user_home']}/#{node['nagios_server']['plugin_tarball_name']}"
  action :run
end

# Extract Plugin packages
execute 'Extract Plugin Package' do
  command "tar -xvzf #{node['nagios_server']['plugin_tarball_name']}"
  cwd node['nagios_server']['user_home']
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['plugin_folder']}/configure") }
end

# Configure Plugin
execute 'Configure Plugin' do
  command './configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl'
  cwd "#{node['nagios_server']['user_home']}/#{node['nagios_server']['plugin_folder']}"
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['plugin_folder']}.txt")}
end


# Make Install & more
execute 'Compile plugin' do
  command 'make'
  cwd "#{node['nagios_server']['user_home']}/#{node['nagios_server']['plugin_folder']}"
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['plugin_folder']}.txt")}
end
execute 'Install plugin' do
  command 'make install'
  cwd "#{node['nagios_server']['user_home']}/#{node['nagios_server']['plugin_folder']}"
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['plugin_folder']}.txt")}
end


# Store the plugin version file.
execute 'Store the Plugin version' do
  command "touch #{node['nagios_server']['user_home']}/#{node['nagios_server']['plugin_folder']}.txt"
  creates "#{node['nagios_server']['user_home']}/#{node['nagios_server']['plugin_folder']}.txt" 
  action :run
end


