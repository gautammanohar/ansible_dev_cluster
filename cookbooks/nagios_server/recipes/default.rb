#
# Cookbook Name:: nagios_server
# Recipe:: default
#
include_recipe 'nagios_server::user'
include_recipe 'nagios_server::install'
include_recipe 'nagios_server::plugins'
include_recipe 'nagios_server::nrpe'

