# == Class: nova::api
#
# Setup and configure the Nova API endpoint
#
# === Parameters
#
# [*admin_password*]
#   (required) The password to set for the nova admin user in keystone
#
# [*enabled*]
#   (optional) Whether the nova api service will be run
#   Defaults to true
#
# [*api_paste_config*]
#   (optional) File name for the paste.deploy config for nova-api
#   Defaults to 'api-paste.ini'
#
# [*manage_service*]
#   (optional) Whether to start/stop the service
#   Defaults to true
#
# [*ensure_package*]
#   (optional) Whether the nova api package will be installed
#   Defaults to 'present'
#
# [*auth_uri*]
#   (optional) Complete public Identity API endpoint.
#   Defaults to 'http://127.0.0.1:5000/'
#
# [*identity_uri*]
#   (optional) Complete admin Identity API endpoint.
#   Defaults to: 'http://127.0.0.1:35357/'
#
# [*admin_tenant_name*]
#   (optional) The name of the tenant to create in keystone for use by the nova services
#   Defaults to 'services'
#
# [*admin_user*]
#   (optional) The name of the user to create in keystone for use by the nova services
#   Defaults to 'nova'
#
# [*api_bind_address*]
#   (optional) IP address for nova-api server to listen
#   Defaults to '0.0.0.0'
#
# [*metadata_listen*]
#   (optional) IP address  for metadata server to listen
#   Defaults to '0.0.0.0'
#
# [*metadata_listen_port*]
#   (optional) The port on which the metadata API will listen.
#   Defaults to 8775
#
# [*enabled_apis*]
#   (optional) A list of apis to enable
#   Defaults to ['osapi_compute', 'metadata']
#
# [*use_forwarded_for*]
#   (optional) Treat X-Forwarded-For as the canonical remote address. Only
#   enable this if you have a sanitizing proxy.
#   Defaults to false
#
# [*osapi_compute_workers*]
#   (optional) Number of workers for OpenStack API service
#   Defaults to $::processorcount
#
# [*osapi_compute_listen_port*]
#   (optional) The port on which the OpenStack API will listen.
#   Defaults to port 8774
#
# [*metadata_workers*]
#   (optional) Number of workers for metadata service
#   Defaults to $::processorcount
#
# [*instance_name_template*]
#   (optional) Template string to be used to generate instance names
#   Defaults to undef
#
# [*sync_db*]
#   (optional) Run nova-manage db sync on api nodes after installing the package.
#   Defaults to true
#
# [*sync_db_api*]
#   (optional) Run nova-manage api_db sync on api nodes after installing the package.
#   Defaults to true
#
# [*neutron_metadata_proxy_shared_secret*]
#   (optional) Shared secret to validate proxies Neutron metadata requests
#   Defaults to undef
#
# [*pci_alias*]
#   (optional) Pci passthrough for controller:
#   Defaults to undef
#   Example
#   "[ {'vendor_id':'1234', 'product_id':'5678', 'name':'default'}, {...} ]"
#
# [*ratelimits*]
#   (optional) A string that is a semicolon-separated list of 5-tuples.
#   See http://docs.openstack.org/trunk/config-reference/content/configuring-compute-API.html
#   Example: '(POST, "*", .*, 10, MINUTE);(POST, "*/servers", ^/servers, 50, DAY);(PUT, "*", .*, 10, MINUTE)'
#   Defaults to undef
#
# [*ratelimits_factory*]
#   (optional) The rate limiting factory to use
#   Defaults to 'nova.api.openstack.compute.limits:RateLimitingMiddleware.factory'
#
# [*enable_proxy_headers_parsing*]
#   (optional) This determines if the HTTPProxyToWSGI
#   middleware should parse the proxy headers or not.(boolean value)
#   Defaults to $::os_service_default
#
# [*default_floating_pool*]
#   (optional) Default pool for floating IPs
#   Defaults to 'nova'
#
# [*validate*]
#   (optional) Whether to validate the service is working after any service refreshes
#   Defaults to false
#
# [*fping_path*]
#   (optional) Full path to fping.
#   Defaults to '/usr/sbin/fping'
#
# [*validation_options*]
#   (optional) Service validation options
#   Should be a hash of options defined in openstacklib::service_validation
#   If empty, defaults values are taken from openstacklib function.
#   Default command list nova flavors.
#   Require validate set at True.
#   Example:
#   nova::api::validation_options:
#     nova-api:
#       command: check_nova.py
#       path: /usr/bin:/bin:/usr/sbin:/sbin
#       provider: shell
#       tries: 5
#       try_sleep: 10
#   Defaults to {}
#
# [*service_name*]
#   (optional) Name of the service that will be providing the
#   server functionality of nova-api.
#   If the value is 'httpd', this means nova-api will be a web
#   service, and you must use another class to configure that
#   web service. For example, use class { 'nova::wsgi::apache'...}
#   to make nova be a web app using apache mod_wsgi.
#   Defaults to '$::nova::params::api_service_name'
#
# [*metadata_cache_expiration*]
#   (optional) This option is the time (in seconds) to cache metadata.
#   Defaults to $::os_service_default
#
# [*vendordata_jsonfile_path*]
#   (optional) Represent the path to the data file.
#   Cloud providers may store custom data in vendor data file that will then be
#   available to the instances via the metadata service, and to the rendering of
#   config-drive. The default class for this, JsonFileVendorData, loads this
#   information from a JSON file, whose path is configured by this option
#   Defaults to $::os_service_default
#
# [*osapi_max_limit*]
#   (optional) This option is limit the maximum number of items in a single response.
#   Defaults to $::os_service_default
#
# [*osapi_compute_link_prefix*]
#   (optional) This string is prepended to the normal URL that is returned in links
#   to the OpenStack Compute API.
#   Defaults to $::os_service_default
#
# [*osapi_glance_link_prefix*]
#   (optional) This string is prepended to the normal URL that is returned in links
#   to Glance resources.
#   Defaults to $::os_service_default
#
# DEPRECATED
#
# [*keystone_ec2_url*]
#   (optional) DEPRECATED. The keystone url where nova should send requests for ec2tokens
#   Defaults to undef
#
# [*volume_api_class*]
#   (optional) DEPRECATED. The name of the class that nova will use to access volumes. Cinder is the only option.
#   Defaults to undef
#
# [*ec2_listen_port*]
#   (optional) DEPRECATED. The port on which the EC2 API will listen.
#   Defaults to port undef
#
# [*auth_version*]
#   (optional) DEPRECATED. API version of the admin Identity API endpoint
#   for example, use 'v3.0' for the keystone version 3.0 api
#   Defaults to false
#
# [*osapi_v3*]
#   (optional) DEPRECATED. Enable or not Nova API v3
#   Defaults to undef
#
# [*ec2_workers*]
#   (optional) DEPRECATED. Number of workers for EC2 service
#   Defaults to undef
#
# [*conductor_workers*]
#   (optional) DEPRECATED. Use workers parameter of nova::conductor
#   Class instead.
#   Defaults to undef
#
class nova::api(
  $admin_password,
  $enabled                      = true,
  $manage_service               = true,
  $api_paste_config             = 'api-paste.ini',
  $ensure_package               = 'present',
  $auth_uri                     = 'http://127.0.0.1:5000/',
  $identity_uri                 = 'http://127.0.0.1:35357/',
  $admin_tenant_name            = 'services',
  $admin_user                   = 'nova',
  $api_bind_address             = '0.0.0.0',
  $osapi_compute_listen_port    = 8774,
  $metadata_listen              = '0.0.0.0',
  $metadata_listen_port         = 8775,
  $enabled_apis                 = ['osapi_compute', 'metadata'],
  $use_forwarded_for            = false,
  $osapi_compute_workers        = $::processorcount,
  $metadata_workers             = $::processorcount,
  $sync_db                      = true,
  $sync_db_api                  = true,
  $neutron_metadata_proxy_shared_secret = undef,
  $default_floating_pool        = 'nova',
  $pci_alias                    = undef,
  $ratelimits                   = undef,
  $ratelimits_factory           =
    'nova.api.openstack.compute.limits:RateLimitingMiddleware.factory',
  $validate                     = false,
  $validation_options           = {},
  $instance_name_template       = undef,
  $fping_path                   = '/usr/sbin/fping',
  $service_name                 = $::nova::params::api_service_name,
  $enable_proxy_headers_parsing = $::os_service_default,
  $metadata_cache_expiration    = $::os_service_default,
  $vendordata_jsonfile_path     = $::os_service_default,
  $osapi_max_limit              = $::os_service_default,
  $osapi_compute_link_prefix    = $::os_service_default,
  $osapi_glance_link_prefix     = $::os_service_default,
  # DEPRECATED PARAMETER
  $conductor_workers            = undef,
  $ec2_listen_port              = undef,
  $ec2_workers                  = undef,
  $keystone_ec2_url             = undef,
  $auth_version                 = false,
  $volume_api_class             = undef,
  $osapi_v3                     = undef,
) inherits nova::params {

  include ::nova::deps
  include ::nova::db
  include ::nova::policy
  include ::cinder::client

  if $osapi_v3 {
    warning('osapi_v3 is deprecated, has no effect and will be removed in a future release.')
  }

  if $volume_api_class {
    warning('volume_api_class parameter is deprecated, has no effect and will be removed in a future release.')
  }

  if $ec2_listen_port or $ec2_workers or $keystone_ec2_url {
    warning('ec2_listen_port, ec2_workers and keystone_ec2_url are deprecated and have no effect. Deploy openstack/ec2-api instead.')
  }

  if $conductor_workers {
    warning('The conductor_workers parameter is deprecated and has no effect. Use workers parameter of nova::conductor class instead.')
  }

  if $instance_name_template {
    nova_config {
      'DEFAULT/instance_name_template': value => $instance_name_template;
    }
  } else {
    nova_config{
      'DEFAULT/instance_name_template': ensure => absent;
    }
  }

  # metadata can't be run in wsgi so we have to enable it in eventlet anyway.
  if ('metadata' in $enabled_apis and $service_name == 'httpd') {
    $enable_metadata = true
  } else {
    $enable_metadata = false
  }

  # sanitize service_name and prepare DEFAULT/enabled_apis parameter
  if $service_name == $::nova::params::api_service_name {
    # if running evenlet, we use the original puppet parameter
    # so people can enable custom service names and we keep backward compatibility.
    $enabled_apis_real = $enabled_apis
    $service_enabled   = $enabled
  } elsif $service_name == 'httpd' {
    # when running wsgi, we want to enable metadata in eventlet if part of enabled_apis
    if $enable_metadata {
      $enabled_apis_real = ['metadata']
      $service_enabled   = $enabled
    } else {
      # otherwise, set it to empty list
      $enabled_apis_real = []
      # if running wsgi for compute, and metadata disabled
      # we don't need to enable nova-api service.
      $service_enabled   = false
    }
    policy_rcd { 'nova-api':
      ensure   => present,
      set_code => '101',
      before   => Package['nova-api'],
    }
    # make sure we start apache before nova-api to avoid binding issues
    Service[$service_name] -> Service['nova-api']
  } else {
    fail('Invalid service_name. Either nova-api/openstack-nova-api for running as a standalone service, or httpd for being run by a httpd server')
  }

  nova::generic_service { 'api':
    enabled        => $service_enabled,
    manage_service => $manage_service,
    ensure_package => $ensure_package,
    package_name   => $::nova::params::api_package_name,
    service_name   => $::nova::params::api_service_name,
    subscribe      => Class['cinder::client'],
  }

  nova_config {
    'wsgi/api_paste_config':             value => $api_paste_config;
    'DEFAULT/enabled_apis':              value => join($enabled_apis_real, ',');
    'DEFAULT/osapi_compute_listen':      value => $api_bind_address;
    'DEFAULT/metadata_listen':           value => $metadata_listen;
    'DEFAULT/metadata_listen_port':      value => $metadata_listen_port;
    'DEFAULT/osapi_compute_listen_port': value => $osapi_compute_listen_port;
    'DEFAULT/osapi_volume_listen':       value => $api_bind_address;
    'DEFAULT/osapi_compute_workers':     value => $osapi_compute_workers;
    'DEFAULT/metadata_workers':          value => $metadata_workers;
    'DEFAULT/use_forwarded_for':         value => $use_forwarded_for;
    'DEFAULT/default_floating_pool':     value => $default_floating_pool;
    'DEFAULT/fping_path':                value => $fping_path;
    'DEFAULT/metadata_cache_expiration': value => $metadata_cache_expiration;
    'DEFAULT/vendordata_jsonfile_path':  value => $vendordata_jsonfile_path;
    'DEFAULT/osapi_max_limit':           value => $osapi_max_limit;
    'DEFAULT/osapi_compute_link_prefix': value => $osapi_compute_link_prefix;
    'DEFAULT/osapi_glance_link_prefix':  value => $osapi_glance_link_prefix;
  }

  oslo::middleware {'nova_config':
    enable_proxy_headers_parsing => $enable_proxy_headers_parsing,
  }

  if ($neutron_metadata_proxy_shared_secret){
    nova_config {
      'neutron/service_metadata_proxy': value => true;
      'neutron/metadata_proxy_shared_secret':
        value => $neutron_metadata_proxy_shared_secret;
    }
  } else {
    nova_config {
      'neutron/service_metadata_proxy':       value  => false;
      'neutron/metadata_proxy_shared_secret': ensure => absent;
    }
  }

  if $auth_version {
    warning('auth_version parameter is deprecated and has no effect during Mitaka and will be dropped during N cycle.')
  }

  nova_config {
    'keystone_authtoken/auth_uri'    : value => $auth_uri;
    'keystone_authtoken/identity_uri': value => $identity_uri;
  }

  nova_config {
    'keystone_authtoken/admin_tenant_name': value => $admin_tenant_name;
    'keystone_authtoken/admin_user':        value => $admin_user;
    'keystone_authtoken/admin_password':    value => $admin_password, secret => true;
  }

  if ($ratelimits != undef) {
    nova_paste_api_ini {
      'filter:ratelimit/paste.filter_factory': value => $ratelimits_factory;
      'filter:ratelimit/limits':               value => $ratelimits;
    }
  }

  # Added arg and if statement prevents this from being run
  # where db is not active i.e. the compute
  if $sync_db {
    include ::nova::db::sync
  }
  if $sync_db_api {
    include ::nova::db::sync_api
  }

  # Remove auth configuration from api-paste.ini
  nova_paste_api_ini {
    'filter:authtoken/auth_uri':          ensure => absent;
    'filter:authtoken/auth_host':         ensure => absent;
    'filter:authtoken/auth_port':         ensure => absent;
    'filter:authtoken/auth_protocol':     ensure => absent;
    'filter:authtoken/admin_tenant_name': ensure => absent;
    'filter:authtoken/admin_user':        ensure => absent;
    'filter:authtoken/admin_password':    ensure => absent;
    'filter:authtoken/auth_admin_prefix': ensure => absent;
  }

  if $pci_alias {
    nova_config {
      'DEFAULT/pci_alias': value => check_array_of_hash($pci_alias);
    }
  }

  if $validate {
    $defaults = {
      'nova-api' => {
        'command'  => "nova --os-auth-url ${auth_uri} --os-tenant-name ${admin_tenant_name} --os-username ${admin_user} --os-password ${admin_password} flavor-list",
      }
    }
    $validation_options_hash = merge ($defaults, $validation_options)
    create_resources('openstacklib::service_validation', $validation_options_hash, {'subscribe' => 'Service[nova-api]'})
  }
}
