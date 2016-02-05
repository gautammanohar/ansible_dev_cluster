#
# Cookbook Name:: nagios_server
# Recipe:: install
#

# Enable RHEL optional repo
execute 'Enable optional repo' do
  command 'yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional'
end

# Install the base packages
node['nagios_server']['base_packages'].each do |p|
  package p do
    action :install
  end
end


# Download nagios tarball
execute 'Download Nagios Tarball' do
  command "wget -q #{node['nagios_server']['tarball_url']} -P #{node['nagios_server']['user_home']}"
  creates "#{node['nagios_server']['user_home']}/#{node['nagios_server']['tarball_name']}"
  action :run
end

# Extract Nagios packages
execute 'Extract Nagios Package' do
  command "tar -xvzf #{node['nagios_server']['tarball_name']}"
  cwd node['nagios_server']['user_home']
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['nagios_folder']}/configure") }
end

# Pre Configure Nagios server
execute 'Configure Nagios installtion' do
  command './configure --with-command-group=nagcmd'
  cwd "#{node['nagios_server']['user_home']}/#{node['nagios_server']['nagios_folder']}"
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['nagios_folder']}.txt")}
end


# Make Install & more
execute 'Make Install and more' do
  command 'make install;make install-commandmode;make install-init;make install-config;make install-webconf'
  cwd "#{node['nagios_server']['user_home']}/#{node['nagios_server']['nagios_folder']}"
  not_if { File.exists?("#{node['nagios_server']['user_home']}/#{node['nagios_server']['nagios_folder']}.txt")}
end

group node['nagios_server']['group'] do
  action :modify
  members 'apache'
  append true
end

# Store the nagios version file.
execute 'Store the Nagios version' do
  command "touch #{node['nagios_server']['user_home']}/#{node['nagios_server']['nagios_folder']}.txt"
  creates "#{node['nagios_server']['user_home']}/#{node['nagios_server']['nagios_folder']}.txt" 
  action :run
end






