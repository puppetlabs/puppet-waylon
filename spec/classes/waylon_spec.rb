require 'spec_helper'

describe 'waylon' do
  let :facts do
    {
      :osfamily               => 'Debian',
      :operatingsystem        => 'Debian',
      :lsbdistcodename        => 'wheezy',
      :lsbmajdistrelease      => '7',
      :operatingsystemrelease => '7.8',
    }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('waylon')            }
    it { should contain_class('waylon::install')   }
    it { should contain_class('waylon::config')    }
    it { should contain_class('waylon::memcached') }
    it { should contain_class('waylon::unicorn')   }
    it { should contain_class('waylon::nginx')     }

    it 'should install default versions of all packages' do
      should contain_rbenv__build('2.1.5').with_global('true')
      should contain_rbenv__gem('waylon').with_version('2.1.3')
      should contain_rbenv__gem('waylon').with_ruby_version('2.1.5')
      should contain_rbenv__gem('unicorn').with_ruby_version('2.1.5')
      should contain_package('nginx')
    end

    it 'should manage waylon.yml with hiera' do
      should contain_file('/usr/local/rbenv/versions/2.1.5/lib/ruby/gems/2.1.0/gems/waylon-2.1.3/config/waylon.yml').with(
        'content' => /refresh_interval: "60"/
      )
      should contain_file('/usr/local/rbenv/versions/2.1.5/lib/ruby/gems/2.1.0/gems/waylon-2.1.3/config/waylon.yml').with(
        'content' => /url: "https:\/\/jenkins\.puppetlabs\.com"/
      )
    end
  end

  context 'with a custom rbenv_install_path' do
    let :params do
      {
        :rbenv_install_path => '/opt/rbenv'
      }
    end

    it { should contain_class('rbenv').with_install_dir('/opt/rbenv') }

    it do
      should contain_file('/etc/default/unicorn').with(
        'content' => /APP_ROOT=\"\/opt\/rbenv/
      )
    end

    it do
      should contain_file('/etc/nginx/nginx.conf').with(
        'content' => /root \/opt\/rbenv/
      )
    end
  end

  context 'with a custom ruby version' do
    let :params do
      {
        :ruby_version => '9000'
      }
    end

    it { should contain_rbenv__build('9000').with_global('true') }

    it do
      should contain_file('/etc/default/unicorn').with(
        'content' => /\/versions\/9000\/lib\//
      )
    end

    it do
      should contain_file('/etc/nginx/nginx.conf').with(
        'content' => /\/versions\/9000\/lib\//
      )
    end
  end

  context 'with a custom unicorn version' do
    let :params do
      {
        :unicorn_version => '9000'
      }
    end

    it { should contain_rbenv__gem('unicorn').with_version('9000') }
  end

  context 'with a custom waylon version' do
    let :params do
      {
        :waylon_version => '9000'
      }
    end

    it { should contain_rbenv__gem('waylon').with_version('9000') }

    it do
      should contain_file('/etc/default/unicorn').with(
        'content' => /waylon-9000/
      )
    end

    it do
      should contain_file('/etc/nginx/nginx.conf').with(
        'content' => /waylon-9000/
      )
    end
  end

  context 'on an unsupported operating system' do
    let :facts do
      {
        :osfamily        => 'Debian',
        :operatingsystem => 'Debian',
        :lsbdistcodename => 'Jessie'
      }
    end

    it do
      expect {
        catalogue
      }.to raise_error(Puppet::Error, /rji-waylon does not support/)
    end
  end
end
