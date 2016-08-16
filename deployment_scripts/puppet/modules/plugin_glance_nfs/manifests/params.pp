class plugin_glance_nfs::params {

  include glance::params

  case $::osfamily {
    'Debian': {
      $package_name = 'nfs-common'
      package { $package_name:
        provider => 'apt',
        install_options => ['--force-yes'],
      }
    }
    'RedHat': {
      $package_name = 'nfs-utils'
      package { $package_name: } ->
      service {'rpcbind':
        ensure => running,
      } ->
      service {'rpcidmapd':
        ensure => running,
      } ->
      service {'nfs':
        ensure => running,
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports osfamily RedHat and Debian")
    }
  }
}
