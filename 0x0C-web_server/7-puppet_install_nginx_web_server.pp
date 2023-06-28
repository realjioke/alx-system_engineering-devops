# Install nginx with puppet
exec { 'install':
  command => 'sudo apt-get -y update && sudo apt-get -y install nginx && echo "Hello World!" | sudo tee /var/www/html/index.nginx-debian.html && sudo sed -i "s/server_name _;/server_name _;\n\trewrite ^\/redirect_me https:\/\/github.com\/realjioke permanent;/" /etc/nginx/sites-available/default && sudo systemctl restart nginx',
}

