# Class: waylon::nginx
# This class manages the Nginx webserver, which serves as a front-end to the
# Unicorn application server running Waylon.
#
class waylon::nginx (
  $app_root,
) {

  package { 'nginx':
    ensure => installed,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('waylon/nginx.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => File['/etc/nginx/nginx.conf'],
  }
}
