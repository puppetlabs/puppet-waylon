# Class: waylon::memcached
# This class manages the memcached server for Waylon to cache responses from
# Jenkins, thus reducing API hits.
#
class waylon::memcached {
  package { 'memcached':
    ensure => installed,
  }

  file { '/etc/memcached_local.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/waylon/memcached.conf',
    notify  => Service['memcached'],
    require => Package['memcached'],
  }

  file { '/var/run/memcached':
    ensure => directory,
    owner  => 'nobody',
    group  => 'root',
    mode   => '0755',
  }

  service { 'memcached':
    ensure  => running,
    enable  => true,
    require => [
      File['/etc/memcached_local.conf'],
      File['/var/run/memcached'],
    ],
  }
}
