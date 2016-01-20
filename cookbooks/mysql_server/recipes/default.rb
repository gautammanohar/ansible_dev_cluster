#
# Cookbook Name:: mysql_server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'mysql_server::install'
include_recipe 'mysql_server::seed'
