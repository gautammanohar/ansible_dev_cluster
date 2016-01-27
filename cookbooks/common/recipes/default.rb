#
# Cookbook Name:: common
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'selinux::disabled'
include_recipe 'common::install'
