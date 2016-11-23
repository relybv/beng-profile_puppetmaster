# == Class profile_puppetmaster::config
#
# This class is called from profile_puppetmaster for service config.
#
class profile_puppetmaster::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

}
