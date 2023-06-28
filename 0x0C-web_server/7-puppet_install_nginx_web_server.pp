# _install_nginx_web_server.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => '
    server {
      listen 80;
      server_name _;
      
      location / {
        return 200 "Hello World!";
      }
      
      location /redirect_me {
        return 301 http://example.com/;
      }
    }
  ',
  notify  => Service['nginx'],
}

# Enable and start Nginx service
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}

