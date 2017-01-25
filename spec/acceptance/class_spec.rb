if ENV['BEAKER'] == 'true'
  # running in BEAKER test environment
  require 'spec_helper_acceptance'
else
  # running in non BEAKER environment
  require 'serverspec'
  set :backend, :exec
end

describe 'profile_puppetmaster class' do

  context 'default parameters' do
    if ENV['BEAKER'] == 'true'
      # Using puppet_apply as a helper
      it 'should work idempotently with no errors' do
        pp = <<-EOS
        class { 'profile_puppetmaster': }
        EOS

        # Run it twice and test for idempotency
        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes  => true)
      end
    end

    describe package('puppetserver') do
      it { is_expected.to be_installed }
    end

    describe service('puppetserver') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(8140) do
      it { should be_listening }
    end

    describe package('puppetdb') do
      it { is_expected.to be_installed }
    end

    describe service('puppetdb') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(8081) do
      it { should be_listening }
    end


  end
end
