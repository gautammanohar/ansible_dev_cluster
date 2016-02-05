#
# Cookbook Name:: hadoop_server
# Recipe:: install
#

# Download hadoop tarball
execute 'download hadoop' do
  command "wget #{node['hadoop_server']['tarball']} -P /tmp/"
  creates node['hadoop_server']['tarball_path']
  action :run
  user node['hadoop_server']['user']
  group node['hadoop_server']['group']
  not_if { File.exists?("#{node['hadoop_server']['tarball_path']}") }
end


# Extract hadoop packages
execute 'extract hadoop' do
  command "tar -xzf #{node['hadoop_server']['tarball_package']} -C #{node['hadoop_server']['user_home']}"
  cwd '/tmp/'
  user node['hadoop_server']['user']
  group node['hadoop_server']['group']
  not_if { File.exists?("#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['folder']}/bin/hadoop") }
end

# Get the Cluster databag
cluster = data_bag_item('hadoop','cluster')
namenode = cluster['name_node']
slaves = cluster['slaves']

# Add the core-site.xml
template "#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['folder']}/etc/hadoop/core-site.xml" do
  source 'core-site.xml.erb'
  variables ({
    :namenode => namenode
  })
  owner node['hadoop_server']['user'] 
  group node['hadoop_server']['group']
end

# Add the yarn-site.xml
template "#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['folder']}/etc/hadoop/yarn-site.xml" do
  source 'yarn-site.xml.erb'
  variables ({
    :namenode => namenode
  })
  owner node['hadoop_server']['user'] 
  group node['hadoop_server']['group']
end

# Add the hdfs-site.xml
template "#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['folder']}/etc/hadoop/hdfs-site.xml" do
  source 'hdfs-site.xml.erb'
  owner node['hadoop_server']['user'] 
  group node['hadoop_server']['group']
end

# Add the mapred-site.xml
template "#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['folder']}/etc/hadoop/mapred-site.xml" do
  source 'mapred-site.xml.erb'
  owner node['hadoop_server']['user'] 
  group node['hadoop_server']['group']
end

# Add the slaves
template "#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['folder']}/etc/hadoop/slaves" do
  source 'slaves.erb'
  variables ({
    :slaves => slaves
  })
  owner node['hadoop_server']['user'] 
  group node['hadoop_server']['group']
end

# Format the filesystem
#execute 'format file system' do
#  command "./hdfs namenode -format"
#  cwd "#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['folder']}/bin/" 
#  user node['hadoop_server']['user']
#  group node['hadoop_server']['group']
#end
