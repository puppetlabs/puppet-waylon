# Class: waylon::params
# Parameters used throughout the Waylon module.
#
class waylon::params {
  $rbenv_install_path = '/usr/local/rbenv'
  $ruby_version       = '2.1.5'
  $unicorn_version    = '4.8.3'
  $waylon_version     = '2.1.2'

  $app_root = "${rbenv_install_path}/versions/${ruby_version}/lib/ruby/gems/2.1.0/gems/waylon-${waylon_version}"
}
