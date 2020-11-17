#
# Cookbook:: my_lamp_stack
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

include_recipe 'my_lamp_stack::pkg'
include_recipe 'my_lamp_stack::apache'
include_recipe 'my_lamp_stack::mysql'