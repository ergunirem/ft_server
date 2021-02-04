# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    init.sh                                            :+:    :+:             #
#                                                      +:+                     #
#    By: icikrikc <icikrikc@student.codam.nl>         +#+                      #
#                                                    +#+                       #
#    Created: 2021/02/03 14:03:48 by icikrikc      #+#    #+#                  #
#    Updated: 2021/02/04 10:28:50 by icikrikc      ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

# Generate website folder & create index.php & move html file
mkdir /var/www/localhost && touch /var/www/localhost/index.php
echo "<?php phpinfo(); ?>" >> /var/www/localhost/index.php
mv ./tmp/index.html /var/www/localhost/index.html

# Config Access
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# SSL
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=NL/ST=Netherlands/L=Amsterdam/O=Codam/OU=icikrikc/CN=localhost"
openssl rsa -noout -text -in /etc/nginx/ssl/localhost.key

# Configure nginx
mv ./tmp/nginx-conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

# Configure mysql
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# Install & Configure phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.zip
unzip phpMyAdmin-4.9.4-all-languages.zip -d /var/www/localhost/
mv /var/www/localhost/phpMyAdmin-4.9.4-all-languages /var/www/localhost/phpmyadmin
mv ./tmp/config.inc.php /var/www/localhost/phpmyadmin/config.inc.php

# Install & Configure wordpress
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/localhost
mv ./tmp/wp-config.php /var/www/localhost/wordpress/

# Boot up php & nginx
service php7.3-fpm start
service nginx start

bash
