include plugin_glance_nfs::params

$fuel_settings = parseyaml($astute_settings_yaml)

$glance_nfs_ip = $::fuel_settings['glance_nfs']['glance_nfs_server_ip']
$glance_nfs_mount_opts = $::fuel_settings['glance_nfs']['nfs_mount_opts']
$glance_share = $::fuel_settings['glance_nfs']['share']
$glance_nfs_share = "$glance_nfs_ip:$glance_share"

file {'/var/lib/glance':
 ensure => directory,
 owner => 'glance',
 group => 'glance'
} ->

exec {'umount_glance':
 path   => "/usr/bin:/usr/sbin:/bin",
 command => 'umount /var/lib/glance',
 unless => "mount | grep glance | grep nfs",
 onlyif => "mount |grep glance",
} ->

mount {'glance':
 name => '/var/lib/glance',
 ensure => mounted,
 atboot => true,
 device => $glance_nfs_share,
 fstype => 'nfs',
 options => $glance_nfs_mount_opts,
 require => Package[$plugin_glance_nfs::params::package_name],
}
