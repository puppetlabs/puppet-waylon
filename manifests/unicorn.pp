# Class: waylon::unicorn
# This class manages the configuration for Unicorn, the application server
# that runs the Waylon application. It is intended to be called from init.pp.
#
class waylon::unicorn (
  $app_root,
  $rbenv_install_path,
  $ruby_version,
) {

  file { '/etc/default/unicorn':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('waylon/unicorn.conf.erb'),
    notify  => Service['unicorn'],
  }

  # pre-requisites
  case $::operatingsystem {
    'debian': {
      $source_initd = 'puppet:///modules/waylon/unicorn.sh'
    }
    'centos': {
      $source_initd = 'puppet:///modules/waylon/unicorn_init_centos.sh'
    }
  }


  file { '/etc/init.d/unicorn':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => $source_initd,
    require => File['/etc/default/unicorn'],
  }

  service { 'unicorn':
    ensure  => running,
    enable  => true,
    require => File['/etc/init.d/unicorn'],
  }
}
