# == Class profile_puppetmaster::install
#
# This class is called from profile_puppetmaster for install.
#
class profile_puppetmaster::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

#  class { '::apache':
#    mpm_module => 'worker',
#  }

  class { '::puppet::profile::master':
#    autosign_method  => 'file',
#    autosign_domains => ['*.sub1.domain.com','*.sub2.domain.com'],
#    require                    => Class['apache'],
    server_type                => 'puppetserver',
    manage_hiera_eyaml_package => false,
  }
}
