default['haproxy']['enable_ssl'] = false
default['haproxy']['enable_admin'] = false
default['haproxy']['enable_default_http'] = false
default['haproxy']['enable_ssl'] = false

default['haproxy']['conf_cookbook'] = 'alfresco'
default['haproxy']['conf_template_source'] = 'haproxy/haproxy.cfg.erb'

default['haproxy']['hostname'] = node['hostname'] ? node['hostname'] : 'localhost'
default['haproxy']['domain'] = node['domain'] ? node['domain'] : 'localdomain'

# TODO - integrate in default configuration
default['haproxy']['ssl_pem_crt_file'] = "/etc/haproxy/haproxy.pem"
default['haproxy']['ssl_pem_crt_databag'] = "ssl"
default['haproxy']['ssl_pem_crt_databag_item'] = "haproxy"

# TODO - integrate in default configuration
default['haproxy']['error_folder'] = "/var/www/html/errors"
default['haproxy']['error_file_cookbook'] = "alfresco"
default['haproxy']['error_file_source'] = "haproxy/errors"

default['haproxy']['port'] = "9000"
default['haproxy']['bind_ip'] = "0.0.0.0"
default['haproxy']['default_backend'] = "share"
default['haproxy']['redirects'] = ["redirect location /share/ if !share_path !alfresco_path !is_aos"]

default['haproxy']['backends']['alfresco']['path_beg'] = ["/alfresco"]
default['haproxy']['backends']['alfresco']['httpchk'] = ["/share"]
default['haproxy']['backends']['alfresco']['nodes'] = [{"id" => node['hosts']['hostname'], "ip" => "127.0.0.1"}]
default['haproxy']['backends']['alfresco']['port'] = 8070

default['haproxy']['backends']['solr4']['path_beg'] = ["/solr4"]
default['haproxy']['backends']['solr4']['httpchk'] = ["/solr4"]
default['haproxy']['backends']['solr4']['nodes'] = [{"id" => node['hosts']['hostname'], "ip" => "127.0.0.1"}]
default['haproxy']['backends']['solr4']['port'] = 8090

default['haproxy']['backends']['share']['path_beg'] = ["/share"]
default['haproxy']['backends']['share']['httpchk'] = ["/share"]
default['haproxy']['backends']['share']['nodes'] = [{"id" => node['hosts']['hostname'], "ip" => "127.0.0.1"}]
default['haproxy']['backends']['share']['port'] = 8081

default['haproxy']['backends']['vti']['path_reg'] = ["^/_vti_inf.html$","^/_vti_bin/.*"]
default['haproxy']['backends']['vti']['port'] = 8070

default['haproxy']['backends']['aos_root']['path_reg'] = ["^/$ method OPTIONS","^/$ method PROPFIND"]
default['haproxy']['backends']['aos_root']['port'] = 8070

default['haproxy']['backends']['aos']['path_reg'] = ["^/alfresco/aos/.*","^/alfresco/aos$"]

default['haproxy']['general_config'] = [
  "global",
  "log 127.0.0.1 local2 info",
  "pidfile /var/run/haproxy.pid",
  "stats socket /var/run/haproxy.stat user haproxy group haproxy mode 600 level admin",
  "user haproxy",
  "group haproxy",
  "defaults",
  "mode http",
  "log global",
  "retries 3",
  "#",
  "# Timeouts",
  "timeout http-request 10s",
  "timeout queue 1m",
  "timeout connect 5s",
  "timeout client 2m",
  "timeout server 2m",
  "timeout http-keep-alive 10s",
  "timeout check 5s"
]
