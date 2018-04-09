# Class: waylon::memcached
# This class manages the memcached server for Waylon to cache responses from
# Jenkins, thus reducing API hits.
#
class waylon::memcached {
  case $::operatingsystem {
    'debian': {
      $owner_memcached = 'nobody'
      $memcached_conf_location = '/etc/memcached_local.conf'
      $memcached_conf_source = 'puppet:///modules/waylon/memcached.conf'
    }
    'centos': {
      $owner_memcached = 'memcached'
      $memcached_conf_location = '/etc/sysconfig/memcached'
      $memcached_conf_source = 'puppet:///modules/waylon/memcached_centos.conf'
    }
  }

  package { 'memcached':
    ensure => installed,
  }

  file { $memcached_conf_location:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $memcached_conf_source,
    notify  => Service['memcached'],
    require => Package['memcached'],
  }

  file { '/var/run/memcached':
    ensure => directory,
    owner  => $owner_memcached,
    group  => 'root',
    mode   => '0755',
  }

  service { 'memcached':
    ensure  => running,
    enable  => true,
    require => [
      File[$memcached_conf_location],
      File['/var/run/memcached'],
    ],
  }
}
