require 'spec_helper'

describe 'profile_puppetmaster' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo"
          })
        end

        context "profile_puppetmaster class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_puppetmaster') }

          it { is_expected.to contain_class('profile_puppetmaster::install') }
          it { is_expected.to contain_class('profile_puppetmaster::config') }
          it { is_expected.to contain_class('profile_puppetmaster::service') }  

        end
      end
    end
  end
end
