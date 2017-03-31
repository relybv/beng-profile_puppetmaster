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

          it { is_expected.to contain_group('puppet') }

          it { is_expected.to contain_exec('/bin/mkdir -p -p /etc/puppetlabs/code/hieradata/production/') }
          it { is_expected.to contain_file('/etc/puppetlabs/code/environments/production/manifests/site.pp') }
          it { is_expected.to contain_file('/etc/puppetlabs/code/hieradata/production/global.yaml') }
          it { is_expected.to contain_file('/etc/puppetlabs/code/hieradata/production/node') }
          it { is_expected.to contain_file('/etc/puppetlabs/code/hieradata/production/role') }
          it { is_expected.to contain_Ini_setting('master dns_alt_names') }
        end
      end
    end
  end
end
