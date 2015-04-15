# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box      = 'puppetlabs/debian-7.8-64-puppet'
  config.vm.hostname = 'waylon-test'
  config.vm.network 'forwarded_port', guest: 80, host: 8080

  config.vm.provider 'virtualbox' do |v|
    v.memory = '2048'
  end

  config.vm.provider 'vmware_fusion' do |v|
    v.vmx['memsize'] = '2048'
  end

  # Symlinked modules in a modulepath are broken. We set up multiple synced
  # folders here to workaround the issue. See PUP-1531. -- roger
  config.vm.synced_folder '.',                     '/vagrant'
  config.vm.synced_folder 'spec/fixtures/modules', '/tmp/puppet/modules'
  config.vm.synced_folder 'spec/fixtures/hiera',   '/tmp/puppet/spec/fixtures/hiera'
  config.vm.synced_folder '.',                     '/tmp/puppet/modules/waylon'

  config.vm.provision 'shell', inline: 'sudo apt-get update'

  config.vm.provision 'puppet' do |pp|
    pp.manifests_path    = 'tests'
    pp.manifest_file     = 'init.pp'
    pp.options           = '--modulepath /tmp/puppet/modules --hiera_config /vagrant/spec/fixtures/hiera/hiera.yaml'  # PUP-1531
    pp.working_directory = '/tmp/puppet'
  end
end
