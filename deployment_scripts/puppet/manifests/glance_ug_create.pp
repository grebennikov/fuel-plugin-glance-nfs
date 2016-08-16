group {'glance':
  ensure => present,
  gid => '901'
} ->

user {'glance':
  ensure => present,
  uid => '901',
  gid => '901',
  home => '/var/lib/glance',
}
