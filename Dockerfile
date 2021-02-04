# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Dockerfile                                         :+:    :+:             #
#                                                      +:+                     #
#    By: icikrikc <icikrikc@student.codam.nl>         +#+                      #
#                                                    +#+                       #
#    Created: 2021/01/14 20:52:14 by icikrikc      #+#    #+#                  #
#    Updated: 2021/02/03 17:34:28 by icikrikc      ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

# Update software packages in debian
RUN apt-get update
RUN apt-get upgrade -y

# Install necessary packages & unzip&wget command
RUN apt-get -y install wget
RUN apt-get -y install unzip
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt install php-fpm php-mysql php-mbstring php-dev php-gd php-pear php-zip php-xml php-curl -y

# Copy necessary files from your host to your image
COPY ./srcs/init.sh ./
COPY ./srcs/index.html ./tmp/index.html
COPY ./srcs/nginx-conf ./tmp/nginx-conf
COPY ./srcs/config.inc.php ./tmp/config.inc.php
COPY ./srcs/wp-config.php ./tmp/wp-config.php

EXPOSE 80 443
ENTRYPOINT ["sh","init.sh"]
