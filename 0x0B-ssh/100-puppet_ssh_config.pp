file { '/etc/ssh/ssh_config':
  ensure  => present,
  content => "    PasswordAuthentication no\n    IdentityFile ~/.ssh/school\n",
  mode    => '0644',
  path    => '/usr/bin:/bin',
}

