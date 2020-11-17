directory "/var/www/#{node['my_wordpress_lamp']['site']}/" do
  action :create
  owner "#{node['my_wordpress_lamp']['site']}"
  group "#{node['my_wordpress_lamp']['site']}"
  mode "2775"
end

cookbook_file 'var/www/latest.tar.gz' do
  source 'latest.tar.gz'
  mode '0755'
  owner 'root'
end

bash "extracting files" do
  cwd "/var/www"
  code <<-EOH
  tar -xzf latest.tar.gz
  cp -r wordpress/* /var/www/#{node['my_wordpress_lamp']['site']}/
  EOH
end

template "/var/www/#{node['my_wordpress_lamp']['site']}/wp-config.php" do
  source 'wp-config.php.erb'
  variables({
    DatabasePassword: 'Vietnam@2020',
    DatabaseName:     node['my_wordpress_lamp']['sql']['database'],
    DatabaseUser:     node['my_wordpress_lamp']['sql']['database_user'],
    DatabaseHost:     node['my_wordpress_lamp']['sql']['database_host']
  })
end

bash 'var-www-perms' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  chown -R root:www /var/www
  chmod 2775 /var/www
  find /var/www -type d -exec chmod 2775 {} \\;
  find /var/www -type f -exec chmod 0664 {} \\;
  EOH
end