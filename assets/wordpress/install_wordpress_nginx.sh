#!/bin/bash

# update and upgrade system
sudo apt-get update
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# install php
sudo apt-get install php-fpm php-mysql -y

# download wordpress
wget https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz

# create wp-config
cd wordpress
cp wp-config-sample.php wp-config.php

# update wp-config
sed -i "s/database_name_here/mydb/g" wp-config.php
sed -i "s/username_here/myuser/g" wp-config.php
sed -i "s/password_here/mypassword/g" wp-config.php
sed -i "s/localhost/${RDS_ENDPOINT}/g" wp-config.php

# move files to nginx
sudo rm -rf /var/www/html
sudo mv wordpress /var/www/html
sudo chown -R www-data:www-data /var/www/html

# update nginx config
sudo sed -i "s/# server_name _;/server_name _;/g" /etc/nginx/sites-available/default
sudo service nginx restart
