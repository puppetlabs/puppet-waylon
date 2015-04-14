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
    it { should contain_class('waylon') }
  end
end
