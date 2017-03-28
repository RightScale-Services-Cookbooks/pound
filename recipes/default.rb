#
# Cookbook Name:: pound
# Recipe:: default
#
# Copyright 2013, RightScale Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
package 'Pound' do
  action :install
end

directory '/etc/pound.d' do
  owner 'root'
  group 'root'
  mode '755'
  action :create
end

template '/etc/pound.cfg' do
  source 'pound.cfg.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(include_files_list: node['pound']['inc_files'])
  action :create
end

template '/etc/pound.d/backend.cfg' do
  source 'backend.cfg.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(backend_host: node['pound']['backend']['host'],
            backend_port: node['pound']['backend']['port'])

  action :create
end
