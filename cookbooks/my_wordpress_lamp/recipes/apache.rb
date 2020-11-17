bash 'create_user' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  mkdir -p /home/#{node['my_wordpress_lamp']['site']}
  useradd -m -d /home/#{node['my_wordpress_lamp']['site']} -s /bin/bash #{node['my_wordpress_lamp']['site']}
  EOH
end

template "/etc/apache2/sites-available/#{node['my_wordpress_lamp']['site']}.conf" do
  source 'vhost.erb'
  variables({
    Website:      node['my_wordpress_lamp']['site'],
    ServerAdmin:  node['my_wordpress_lamp']['vhost']['server_admin'],
    ServerName:   node['my_wordpress_lamp']['vhost']['server_name'],
    ServerAlias:  node['my_wordpress_lamp']['vhost']['server_alias'],
    Port:         node['my_wordpress_lamp']['vhost']['port']
  })
end

bash "config site" do
  cwd "/etc/apache2/sites-available/"
  code <<-EOH
  a2ensite #{node['my_wordpress_lamp']['site']}.conf
  a2dissite *.conf
  a2ensite #{node['my_wordpress_lamp']['site']}.conf
  EOH
end

service 'apache2' do
  action :restart
end