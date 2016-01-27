#
# Cookbook Name:: dns_server
# Recipe:: default
#
include_recipe 'dns_server::install'
include_recipe 'dns_server::configure'
