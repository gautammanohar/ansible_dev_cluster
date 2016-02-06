#
# Cookbook Name:: hadoop_server
# Recipe:: scala
#

# Download scala tarball
execute 'Download Scala Tarball' do
  command "wget -q #{node['hadoop_server']['scala_tarball_url']} -P #{node['hadoop_server']['user_home']}"
  creates "#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['scala_tarball_name']}"
  action :run
end

# Extract Tarball package
execute 'Extract Scala Tarball Package' do
  command "tar -xvzf #{node['hadoop_server']['scala_tarball_name']}"
  cwd node['hadoop_server']['user_home']
  not_if { File.exists?("#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['scala_folder']}/lib/scalap-2.11.7.jar") }
end


# Move to location
execute 'Move scala binaries' do
  command "mv #{node['hadoop_server']['scala_folder']} /usr/local/scala"
  cwd node['hadoop_server']['user_home']
  not_if { File.exists?("/usr/local/scala/lib/scalap-2.11.7.jar") }
end






