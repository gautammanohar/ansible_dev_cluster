#
# Cookbook Name:: mongo_server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'mongo_server::install'
include_recipe 'mongo_server::seed'
