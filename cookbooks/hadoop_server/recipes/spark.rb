#
# Cookbook Name:: hadoop_server
# Recipe:: spark
#

# Download Spark tarball
execute 'Download Spark Tarball' do
  command "wget -q #{node['hadoop_server']['spark_tarball_url']} -P #{node['hadoop_server']['user_home']}"
  creates "#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['spark_tarball_name']}"
  action :run
end

# Extract Tarball package
execute 'Extract Spark Tarball Package' do
  command "tar -xvzf #{node['hadoop_server']['spark_tarball_name']}"
  cwd node['hadoop_server']['user_home']
  not_if { File.exists?("#{node['hadoop_server']['user_home']}/#{node['hadoop_server']['spark_folder']}/sbin/start-all.sh") }
end

# Move to location
execute 'Move spark binaries' do
  command "mv #{node['hadoop_server']['spark_folder']} /usr/local/spark"
  cwd node['hadoop_server']['user_home']
  not_if { File.exists?("/usr/local/spark/sbin/start-all.sh") }
end

# Get the Cluster databag
cluster = data_bag_item('hadoop','cluster')
namenode = cluster['name_node']
slaves = cluster['slaves']

# Add spark-env.sh
template "/usr/local/spark/conf/spark-env.sh" do
  source 'spark-env.sh.erb'
  variables ({
    :namenode => namenode
  })
end

# Add spark-defaults.sh
template "/usr/local/spark/conf/spark-defaults.conf" do
  source 'spark-defaults.conf.erb'
  variables ({
    :namenode => namenode
  })
end

# Add the slaves
template "/usr/local/spark/conf/slaves" do
  source 'spark-slaves.erb'
  variables ({
    :slaves => slaves
  })
end




