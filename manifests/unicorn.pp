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

  file { '/etc/init.d/unicorn':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/waylon/unicorn.sh',
    require => File['/etc/default/unicorn'],
  }

  service { 'unicorn':
    ensure  => running,
    enable  => true,
    require => File['/etc/init.d/unicorn'],
  }
}
