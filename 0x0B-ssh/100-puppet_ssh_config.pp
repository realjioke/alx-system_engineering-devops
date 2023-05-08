file { '/etc/ssh/ssh_config':
  ensure  => present,
  content => "    PasswordAuthentication no\n    IdentityFile ~/.ssh/school\n",
  mode    => '0644',
}

exec { 'echo':
  path    => '/usr/bin:/bin',
  command => 'echo "    PasswordAuthentication no\n    IdentityFile ~/.ssh/school" >> /etc/ssh/ssh_config',
  returns => [0,1]
}

