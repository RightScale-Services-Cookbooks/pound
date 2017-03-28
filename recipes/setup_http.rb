template '/etc/pound.d/http.cfg' do
  source 'http.cfg.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
