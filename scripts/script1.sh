dnf -y install httpd
systemctl enable httpd
systemctl start httpd
dnf -y install mariadb-server
systemctl enable mariadb
systemctl start mariadb
#mysql_secure_installation
dnf -y install php php-common php-mysqlnd php-gd php-imap php-xml php-cli php-opcache php-mbstring
#grep acl /etc/php-fpm.d/www.conf
systemctl enable php-fpm
systemctl start php-fpm
chown apache:apache /run/php-fpm/www.sock
echo "<?php phpinfo(); ?>" >> /var/www/html/info.php
curl http://127.0.0.1/info.php
dnf -y install wget
wget http://wordpress.org/latest.tar.gz
tar xvfz latest.tar.gz -C /var/www/html/
#mysql -u root -p
#CREATE USER wpuser@localhost IDENTIFIED BY "testadmin208";
#CREATE DATABASE wp_database;
#GRANT ALL ON wp_database.* TO wpuser@localhost;
#FLUSH PRIVILEGES;
#quit
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
#vi /var/www/html/wordpress/wp-config.php
