# == Class profile_puppetmaster::install
#
# This class is called from profile_puppetmaster for install.
#
class profile_puppetmaster::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { $::profile_puppetmaster::package_name:
    ensure => present,
  }
}
