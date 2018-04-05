# Class: waylon::params
# Parameters used throughout the Waylon module.
#
class waylon::params {

  # Waylon defaults
  $rbenv_install_path = '/usr/local/rbenv'
  $ruby_version       = '2.2.2'
  $unicorn_version    = '4.8.3'
  $waylon_version     = '2.1.4'

  # Config defaults
  $refresh_interval  = hiera('waylon::config::refresh_interval', '120')
  $trouble_threshold = hiera('waylon::config::trouble_threshold', '0')
  $memcached_server  = hiera('waylon::config::memcached_server', '/var/run/memcached/memcached.sock')
  $views             = hiera('waylon::config::views', {})
}
