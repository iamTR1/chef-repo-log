#
# Cookbook:: my_wordpress_lamp
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

include_recipe 'my_wordpress_lamp::apache'
include_recipe 'my_wordpress_lamp::mysql'
include_recipe 'my_wordpress_lamp::wordpress'