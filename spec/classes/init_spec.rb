require 'spec_helper'
describe 'waylon' do

  context 'with defaults for all parameters' do
    it { should contain_class('waylon') }
  end
end
