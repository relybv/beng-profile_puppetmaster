# == Class profile_puppetmaster::install
#
# This class is called from profile_puppetmaster for install.
#
class profile_puppetmaster::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  class { '::puppet::profile::master':
    server_type                => 'puppetserver',
    puppetdb                   => true,
    manage_hiera_eyaml_package => false,
    hiera_hierarchy            => [ 'node/%{::clientcert}',  'role/%{::role}', 'env/%{::environment}', 'global' ],
  }


  if ( versioncmp($::puppetversion, '4.0.0') >= 0 ) {
    $puppetconfdir = '/etc/puppetlabs/puppet'
  } else {
    $puppetconfdir = '/etc/puppet'
  }

  ini_setting { 'master dns_alt_names':
      ensure  => present,
      path    => "${puppetconfdir}/puppet.conf",
      section => 'main',
      setting => 'dns_alt_names',
      value   => "puppet.${::domain}, puppet",
    }
}
