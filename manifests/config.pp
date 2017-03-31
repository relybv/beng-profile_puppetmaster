# == Class profile_puppetmaster::config
#
# This class is called from profile_puppetmaster for service config.
#
class profile_puppetmaster::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # prepare directorys
  exec { '/bin/mkdir -p -p /etc/puppetlabs/code/hieradata/production/':
    creates => '/etc/puppetlabs/code/hieradata/production/',
  }

  # site.pp only contain hiera_include('classes', [])
  file { '/etc/puppetlabs/code/environments/production/manifests/site.pp':
    source => 'puppet:///modules/profile_puppetmaster/site.pp',
  }

  # define roles, a role is set by a custom fact in the profile_base module
  file { '/etc/puppetlabs/code/hieradata/production/role':
    recurse => true,
    source  => 'puppet:///modules/profile_puppetmaster/role',
  }

  # define nodes
  file { '/etc/puppetlabs/code/hieradata/production/node':
    recurse => true,
    source  => 'puppet:///modules/profile_puppetmaster/node',
  }

  # /etc/puppetlabs/code/hieradata/production/global.yaml
  file { '/etc/puppetlabs/code/hieradata/production/global.yaml':
    source => 'puppet:///modules/profile_puppetmaster/global.yaml',
  }
}
