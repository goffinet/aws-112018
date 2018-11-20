#!/bin/bash

ip_adress=$(curl -s https://ipinfo.io/ip)
site_title="Demo Wordpress"
site_url="http://www.${ip_adress}.xip.io"
application_path="/var/www/html"
admin_email="test@test.com"
admin_user="admin"
admin_password=$(pwmake 128 | head -c12)
dbuser="wpuser"
dbroot_password=$(pwmake 128 | head -c12)
dbuser_password=$(pwmake 128 | head -c12)

software_installation() {
dnf -y install httpd mariadb-server php php-common php-mysqlnd php-gd php-imap php-xml php-cli php-opcache php-mbstring wget
sed -i 's/^listen.acl_users/;listen.acl_users/g' /etc/php-fpm.d/www.conf
}

enable_start_services() {
systemctl enable httpd mariadb php-fpm
systemctl start httpd mariadb php-fpm
chown apache:apache /run/php-fpm/www.sock
}

open_firewall() {
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload
}

mysql_secure() {
mysql -e "UPDATE mysql.user SET Password = PASSWORD('${dbroot_password}') WHERE User = 'root'"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"
mysql -e "DROP DATABASE test"
mysql -e "FLUSH PRIVILEGES"
}

wordpress_database_creation() {
mysql -e "CREATE USER ${dbuser}@localhost IDENTIFIED BY '${dbuser_password}'"
mysql -e "CREATE DATABASE wp_database"
mysql -e "GRANT ALL ON wp_database.* TO ${dbuser}@localhost"
mysql -e "FLUSH PRIVILEGES"
}

store_passwords() {
echo ${dbroot_password} > ~/.pw_wordpress
echo ${dbuser_password} > ~/.pw_wordpress
echo ${admin_password} > ~/.pw_wordpress
chmod 600 ~/.pw_wordpress
}

test_stack() {
# Test Apache
if [ $(curl -s -I 127.0.0.1 | grep -q 'Server: Apache/2.4.34 (Fedora)' ; echo $?) == '0' ] ; then
echo "Apache is working" ; else
echo "Apache is NOT working" ; fi
# Test PHP
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
if [ $(curl -s -G http://127.0.0.1/info.php | grep -q 'phpinfo' ; echo $?) == '0' ] ; then
echo "PHP is working" ; else
echo "PHP is NOT working" ; fi
rm -f /var/www/html/info.php
}
