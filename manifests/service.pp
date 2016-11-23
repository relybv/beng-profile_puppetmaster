# == Class profile_puppetmaster::service
#
# This class is meant to be called from profile_puppetmaster.
# It ensure the service is running.
#
class profile_puppetmaster::service {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { $::profile_puppetmaster::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
