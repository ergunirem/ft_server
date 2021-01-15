# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: icikrikc <icikrikc@student.codam.nl>         +#+                      #
#                                                    +#+                       #
#    Created: 2021/01/14 20:52:14 by icikrikc      #+#    #+#                  #
#    Updated: 2021/01/15 21:25:35 by icikrikc      ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

# Update software packages in debian
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

# Install necessary packages
RUN apt-get -y install nginx
# RUN apt-get -y install mariadb-server
# RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

# # install phpmyadmin by using ‘wget’
# WORKDIR /var/www/html/
# RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
# RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
# RUN mv phpMyAdmin-5.0.1-english phpmyadmin

# # move the config file to srcs folder
COPY /srcs/nginx-conf /etc/nginx/sites-available/
# COPY ./srcs/config.inc.php phpmyadmin
# remove default symlink and create symlink in sites enabled
WORKDIR /etc/nginx/sites-enabled
RUN rm default
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

# restart nginx
# RUN service nginx reload

# expose port
EXPOSE 80
