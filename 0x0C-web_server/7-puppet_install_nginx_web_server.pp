# Install nginx with puppet
exec { 'install_nginx':
  command  => 'apt-get -y update && apt-get -y install nginx',
  path     => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  provider => shell,
}

exec { 'create_index_file':
  command  => 'echo "Hello World!" | tee /var/www/html/index.nginx-debian.html',
  path     => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  provider => shell,
}

exec { 'configure_redirect':
  command  => 'sed -i "s/server_name _;/server_name _;\n\trewrite ^\/redirect_me https:\/\/github.com\/jesulayomy permanent;/" /etc/nginx/sites-available/default',
  path     => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  provider => shell,
}

exec { 'start_nginx':
  command  => 'service nginx start',
  path     => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  provider => shell,
}

