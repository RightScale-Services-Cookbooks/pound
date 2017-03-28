name             'pound'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures pound'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'
issues_url       'https://github.com/RightScale-Services-Cookbooks/pound/issues'
source_url       'https://github.com/RightScale-Services-Cookbooks/pound'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'yum-epel'

recipe 'pound::default', 'installs and configures pound'
recipe 'pound::setup_http', 'sets up http frontend'
recipe 'pound::setup_https', 'sets up https frontend'

attribute 'pound/ssl/chain',
  display_name: 'Pound SSL Chainfile',
  description: 'Pound SSL Chainfile',
  required: 'required',
  recipes: ['pound::setup_https']

attribute 'pound/ssl/key',
  display_name: 'Pound SSL Key',
  description: 'Pound SSL Key',
  required: 'required',
  recipes: ['pound::setup_https']

attribute 'pound/ssl/cert',
  display_name: 'Pound SSL Certificate',
  description: 'Pound SSL Certificate',
  required: 'required',
  recipes: ['pound::setup_https']
