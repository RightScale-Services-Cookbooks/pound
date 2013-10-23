directory "/etc/pound.d/ssl" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "/etc/pound.d/ssl/cert.pem" do
  source "cert.pem.erb"
  owner "root"
  group "root"
  mode "0600"
  variables( :chain => node[:pound][:ssl][:chain],
             :key => node[:pound][:ssl][:key],
             :cert => node[:pound][:ssl][:cert] )
  action :create
end

template "/etc/pound.d/https.cfg" do
  source "https.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end