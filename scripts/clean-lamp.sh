#! /bin/bash
# clean-lamp.sh
systemctl stop httpd mariadb php-fpm
systemctl stop apache2 mysql
systemctl disable httpd mariadb php-fpm
systemctl disable apache2 mysql
dnf -y remove mariadb mariadb-server httpd php-fpm
apt -y remove apache2 mariadb-server
rm -rf /var/lib/mysql
rm -r /etc/my.cnf
rm -r ~/.my.cnf
rm -rf /var/www/html/*
rm -rf /etc/httpd*
rm -rf /etc/apache2/*
rm -rf /etc/php-fpm*
firewall-cmd --zone=public --permanent --remove-service=http
firewall-cmd --reload
