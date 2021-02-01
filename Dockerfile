# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: icikrikc <icikrikc@student.codam.nl>         +#+                      #
#                                                    +#+                       #
#    Created: 2021/01/14 20:52:14 by icikrikc      #+#    #+#                  #
#    Updated: 2021/02/01 14:53:35 by icikrikc      ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

# Update software packages and wget command in debian
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

# Install necessary packages
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap

#Configure nginx
COPY srcs/localhost /etc/nginx/sites-available/

#Install and cofigure phpmyadmin & wordpress
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
COPY ./srcs/config.inc.php phpmyadmin
WORKDIR /var/www/html/
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
COPY ./srcs/wp-config.php /var/www/html

# SSL
RUN openssl req -x509 -nodes -days 365 -subj "/C=NL/ST=Netherlands/L=Amsterdam/O=Codam/OU=Codam/CN=icikrikc" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

EXPOSE 80  443
RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*
COPY ./srcs/init.sh .
CMD bash init.sh

