pound Cookbook
==============
http://www.apsis.ch/pound
POUND - REVERSE-PROXY AND LOAD-BALANCER

The Pound program is a reverse proxy, load balancer and HTTPS front-end for Web server(s). 
Pound was developed to enable distributing the load among several Web-servers and to allow 
for a convenient SSL wrapper for those Web servers that do not offer it natively.

WHAT POUND IS:

    1.a reverse-proxy: it passes requests from client browsers to one or more back-end servers.
    2.a load balancer: it will distribute the requests from the client browsers among several back-end servers, while keeping session information.
    3.an SSL wrapper: Pound will decrypt HTTPS requests from client browsers and pass them as plain HTTP to the back-end servers.
    4.an HTTP/HTTPS sanitizer: Pound will verify requests for correctness and accept only well-formed ones.
    5.a fail over-server: should a back-end server fail, Pound will take note of the fact and stop passing requests to it until it recovers.
    6.a request redirector: requests may be distributed among servers according to the requested URL.

Pound is a very small program, easily audited for security problems. It can run as setuid/setgid and/or in a chroot jail. 
Pound does not access the hard-disk at all (except for reading the certificate file on start, if required) 
and should thus pose no security threat to any machine.

WHAT POUND IS NOT:

    1.Pound is not a Web server: by itself, Pound serves no content - it contacts the back-end server(s) for that purpose.
    2.Pound is not a Web accelerator: no caching is done - every request is passed "as is" to a back-end server.

Requirements
==============
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

The following code block needs to be added to the Varnish VCL:
# Getting Varnish and Pound to play nicely required the vcl_hash block below
# https://www.adammalone.net/post/why-pound-awesome-front-varnish#.VaZwh6bDTef
sub vcl_hash 
 {
 hash_data(req.url);
  if (req.http.host) {
    hash_data(req.http.host);
  } 
  else {
    hash_data(server.ip);
  }
  # Use special internal SSL hash for https content
  # X-Forwarded-Proto is set to https by Pound
  if (req.http.X-Forwarded-Proto ~ "https") {
    hash_data(req.http.X-Forwarded-Proto);
  }
  return (hash);
}

Attributes
==============
TODO: List you cookbook attributes here.
default[:pound][:xhttp]="1"
default[:pound][:backend][:host]="127.0.0.1"
default[:pound][:backend][:port]="8000"
Backend application running on port 8000

default[:pound][:inc_files]=["/etc/pound.d/backend.cfg"]

default[:pound][:ssl][:key]=""
The SSL Key
default[:pound][:ssl][:cert]=""
The SSL Cert
default[:pound][:ssl][:chain]=""
The SSL chain

Recipes
==============

pound::default

pound::setup_http

pound::setup_https


Usage
==============
TODO: Write usage instructions for each cookbook.
For SSL enablement with Varnish you will need the following:

pound::default

pound::setup_https

  The following inputs will have to be updated with their values:
  	SSL KEY
  	SSL Cert
  	SSL Chain
  	

Contributing
==============
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
==============
Author:: RightScale, Inc. (cookbooks@rightscale.com)
