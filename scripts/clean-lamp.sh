#! /bin/bash
# clean-lamp.sh
systemctl stop httpd mariadb php-fpm
systemctl disable httpd mariadb php-fpm
dnf -y remove mariadb mariadb-server httpd php-fpm
rm -rf /var/lib/mysql
rm -r /etc/my.cnf
rm -r ~/.my.cnf
rm -rf /var/www/html/*
rm -rf /etc/httpd*
rm -rf /etc/php-fpm*
firewall-cmd --zone=public --permanent --remove-service=http
firewall-cmd --reload
