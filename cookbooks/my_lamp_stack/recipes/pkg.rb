#  Install
execute 'apache_update' do
  command 'apt update -y'
end

%w(
  apache2
  php
  mysql-server
  php-mysqlnd
  expect
).each do |pkg|
  package pkg do
    action :install
  end
end

group 'www' do
  action :create
end