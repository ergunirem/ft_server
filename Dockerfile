FROM debian:10

# Update software packages in debian
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

# Install nginx
RUN apt-get -y install nginx

# Install MySQL/MariaDB
RUN apt-get -y install mariadb-server
