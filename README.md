# ft_server
This is a project I have created for CODAM curriculum. You can see the ft_server.pdf and my notes (notes.pdf) on the subject for further information.
To run this project, clone the repo and do 1)docker build -t nginx . and 2) docker run -p 80:80 -p 443:443 -it --rm nginx in your command line. 
Now, check your https://localhost/ to see the website you created with docker.

## Summary:

> This is a System Administration subject. You will discover Docker and you will set up your `first web server`

This topic is intended to introduce you to system administration. It will make you aware of the importance of using scripts to automate your tasks. For that, you will discover the "docker" technology and use it to install a complete web server. This server will run multiples services: Wordpress, phpMyAdmin, and a SQL database.

## Mandatory Part:

- You must set up a web server with Nginx, in only one docker container. The container OS must be debian buster.
- Your web server must be able to run several services at the same time. The services will be a WordPress website, phpMyAdmin and MySQL. You will need to make sure your SQL database works with the WordPress and phpMyAdmin.
- Your server should be able to use the SSL protocol.
- You will have to make sure that, depending on the url, your server redirects to the correct website.
- You will also need to make sure your server is running with an autoindex that must be able to be disabled.

## Tools

First, a quick overview of the tools we are going to use:

- **Docker** is a software platform for building applications based on containers.
- **NGINX** is a free web server software particularly suitable for websites with high traffic. Unlike Apache, it is light and fast but has fewer modules than Apache (this tends to weaken over the years).
- **MySQL** is a Relational Database Management System that helps you to keep the data that exists in a database organised. **+ MariaDB:** MariaDB is a fork of the MySQL database management system.
- **phpMyAdmin** is a web application for managing MySQL databases.
- **WordPress** is a free and open-source content management system based on the PHP and MySQL programming languages.
- **Debian** is a popular and freely-available computer operating system that uses the Linux kernel and other program components obtained from the GNU project.

### What to do explained in simple steps?

1) Create OS container based on debian with Docker

2) Load nginx to debian

3) Upload Mysql to be used by nginx web server

4) Use MySQL with wordpress and phpmyadmin

5) Automate the above process using dockerfile
