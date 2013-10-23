name             'pound'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures pound'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

recipe "pound::default", "installs and configures pound"
recipe "pound::setup_http", "sets up http frontend"
recipe "pound::setup_https", "sets up https frontend"
