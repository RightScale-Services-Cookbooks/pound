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
  only_if { node[:pound][:ssl][:cert] }
end

node normal[:pound][:inc_files]<<'/etc/pound.d/https.cfg'
template "/etc/pound.d/https.cfg" do
  source "https.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
  variables( :xhttp => node[:pound][:xhttp] )
  action :create
end

service "pound" do
  action [ :enable, :start ]
end
