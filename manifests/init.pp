# Class: waylon
# This class is the main entry point into the rji-waylon Puppet module. Other
# classes in the 'manifests/' directory are called from this class. Params can
# be overridden, but the defaults in params.pp should be sane for most use
# cases.
#
class waylon (
  $rbenv_install_path = $::waylon::params::rbenv_install_path,
  $ruby_version       = $::waylon::params::ruby_version,
  $unicorn_version    = $::waylon::params::unicorn_version,
  $waylon_version     = $::waylon::params::waylon_version,
) inherits ::waylon::params {

  # Build the path to the application working directory based on params
  $app_root = "${rbenv_install_path}/versions/${ruby_version}/lib/ruby/gems/2.1.0/gems/waylon-${waylon_version}"

  # Up to this point, we only support running on Debian 7 "Wheezy".
  # This is likely to change in the future.
  if $::lsbdistcodename != 'wheezy' {
    fail("rji-waylon does not support ${::operatingsystem} ${::lsbdistcodename}")
  }

  anchor { 'waylon::begin': }
  anchor { 'waylon::end': }

  class { '::waylon::install':
    rbenv_install_path => $rbenv_install_path,
    ruby_version       => $ruby_version,
    unicorn_version    => $unicorn_version,
    waylon_version     => $waylon_version,
    require            => Anchor['waylon::begin'],
    before             => Class['waylon::config'],
  }

  class { '::waylon::config':
    app_root => $app_root,
    before   => Class['waylon::memcached'],
  }

  class { '::waylon::memcached':
    before  => Class['waylon::unicorn'],
  }

  class { '::waylon::unicorn':
    app_root           => $app_root,
    rbenv_install_path => $rbenv_install_path,
    ruby_version       => $ruby_version,
    before             => Class['waylon::nginx'],
  }

  class { '::waylon::nginx':
    app_root => $app_root,
    before   => Anchor['waylon::end'],
  }
}
