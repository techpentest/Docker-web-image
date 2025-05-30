# Create Docker Image for Apache webserver

from ubuntu:latest
label version v1.0
label author devopsadmin
maintainer description="devopsadmin"

run sudo apt-get update -y && \
apt-get upgrade -y && \
apt install apache2 -y

copy ./index.html /var/www/html/
expose 80

cmd ["apache2ctl","-D","FOREGROUND"]
