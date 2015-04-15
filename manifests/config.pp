# Class: waylon::config
# Generate the 'waylon.yml' configuration file.
#
class waylon::config (
  $app_root          = $::waylon::params::app_root,
  $refresh_interval  = $::waylon::params::refresh_interval,
  $trouble_threshold = $::waylon::params::trouble_threshold,
  $memcached_server  = $::waylon::params::memcached_server,
  $views             = $::waylon::params::views,
) inherits ::waylon::params {

  # Build a hash so we can convert it to YAML in waylon.yml.erb
  $config = {
    'refresh_interval'  => $refresh_interval,
    'trouble_threshold' => $trouble_threshold,
    'memcached_server'  => $memcached_server,
  }

  file { "${app_root}/config/waylon.yml":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('waylon/waylon.yml.erb'),
  }
}