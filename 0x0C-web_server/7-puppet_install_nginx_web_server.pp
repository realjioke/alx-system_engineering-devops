# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Configure Nginx site
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => "
    server {
      listen 80 default_server;
      listen [::]:80 default_server;

      root /var/www/html;
      index index.html index.htm;

      location / {
        return 301 https://www.example.com$request_uri;
      }
      
      error_page 404 /404.html;
      location = /404.html {
        root /var/www/html;
      }
    }
  ",
}

# Enable Nginx site
file { '/etc/nginx/sites-enabled/default':
  ensure => 'link',
  target => '/etc/nginx/sites-available/default',
  require => File['/etc/nginx/sites-available/default'],
}

# Restart Nginx service
service { 'nginx':
  ensure    => 'running',
  enable    => true,
  subscribe => File['/etc/nginx/sites-enabled/default'],
}

