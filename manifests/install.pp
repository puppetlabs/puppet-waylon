# Class: waylon::install
# This class manages a system-wide rbenv install, and installs Unicorn and
# Waylon into it. This class is intended to be called from init.pp.
#
class waylon::install (
  $rbenv_install_path,
  $ruby_version,
  $unicorn_version,
  $waylon_version,
  $manage_deps = true,
) {

  # pre-requisites
  case $::operatingsystem {
    'debian': {
      if $::lsbdistcodename == 'wheezy' {
        # build-essential and libssl-dev are req'd for the rbenv ruby-build plugin.
        # libsasl2-dev and gettext are req'd for building native extensions for the
        # memcached gem.
        package { ['build-essential', 'libssl-dev', 'libsasl2-dev', 'gettext']:
          ensure => installed,
          before => Class['rbenv'],
        }
      }
    }
    'centos': {
      package { ['git-core', 'zlib', 'zlib-devel', 'gcc-c++', 'patch', 'readline', 'readline-devel', 'libyaml-devel', 'libffi-devel', 'openssl-devel', 'make', 'bzip2', 'autoconf', 'automake', 'libtool', 'bison', 'curl', 'sqlite-devel']:
        ensure => installed,
        before => Class['rbenv'],
      }
    }
  }


  class { '::rbenv':
    install_dir => $rbenv_install_path,
    latest      => true,
    manage_deps => $manage_deps,
  }

  rbenv::plugin { 'sstephenson/ruby-build':
    latest => true,
  }

  rbenv::build { $ruby_version:
    global => true,
  }

  rbenv::gem { 'unicorn':
    ruby_version => $ruby_version,
    version      => $unicorn_version,
    skip_docs    => true,
  }

  rbenv::gem { 'waylon':
    ruby_version => $ruby_version,
    version      => $waylon_version,
    skip_docs    => true,
  }

  file { '/var/log/waylon':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}
