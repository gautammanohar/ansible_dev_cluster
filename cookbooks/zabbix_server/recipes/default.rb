#
# Cookbook Name:: zabbix_server
# Recipe:: default
#
include_recipe 'zabbix_server::user'
include_recipe 'zabbix_server::db'
include_recipe 'zabbix_server::download'
include_recipe 'zabbix_server::install'
