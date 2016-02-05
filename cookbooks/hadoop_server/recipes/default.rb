#
# Cookbook Name:: hadoop_server
# Recipe:: default
#

include_recipe 'hadoop_server::users'
include_recipe 'hadoop_server::install'
