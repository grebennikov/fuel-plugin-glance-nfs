group {'nova':
  ensure => present,
  gid => '900'
} ->

user {'nova':
  ensure => present,
  uid => 900,
  gid => 900,
  home => '/var/lib/nova',
}
