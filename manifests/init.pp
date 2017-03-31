# == Class: profile_puppetmaster
#
# Full description of class profile_puppetmaster here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class profile_puppetmaster
{
  ensure_resource('group', 'puppet', {'ensure' => 'present'})
  class { '::profile_puppetmaster::install': }
  -> class { '::profile_puppetmaster::config':
    notify => Service[ 'puppetserver' ],
  }
  ~> class { '::profile_puppetmaster::service': }
  -> Class['::profile_puppetmaster']
}
