# Lab Automation LAMP Wordpress

<!-- toc -->

Vous vous initiez à l'administration DevOps du [moteur de blogging Wordpress](https://fr.wikipedia.org/wiki/WordPress). Dans une première approche vous cherchez un base pour commencer votre déploiement. Vous choisissez un article dont le nom est évocateur : [How to Install LAMP Stack on Fedora 27](https://linoxide.com/linux-how-to/install-lamp-stack-fedora-27/). Car la machine qui est approvisionnée chez Scaleway est un START1-XS avec une image Fedora 27.

Vous démarrez donc en [Fedora 27](https://fr.wikipedia.org/wiki/Fedora_(GNU/Linux)) pour déployer un serveur Wordpress basé sur le [stack LAMP](https://fr.wikipedia.org/wiki/LAMP).

## 1. Premiers essai

À la lecture du tuto, la procédure se résume en deux étapes principales auxquelles correspondent les tâches suivantes.

1. Déploiement du stack LAMP
  1. Installation et test du serveur Web
  * Installation et sécurisation du service de base données
  * Installation et test de PHP
* Déploiement de l'application Wordpress
  1. Téléchargement de Wordpress
  * Création de la base de données de Wordpress
  * Création du fichier de configuration de wordpress
  * Installation manuelle de Wordpress

### 1.1. Méthodologie et consigne

Exécutez chaque commande opérationnelle. Copiez les actions qui s'exécutent avec succès dans fichier destiné à devenir un script d'automatisation Bash.

Veuillez également exécuter les commandes de diagnostic, évaluer celles qui conviennent le mieux à des tests et les retenir dans votre fichier de travail.

### 1.2. Apache

#### Installation et activation

```bash
dnf install httpd
```

```bash
systemctl enable httpd.service
systemctl start httpd.service
```
#### Tests

Apache :

```bash
systemctl status httpd
```

```bash
journalctl -f -l -u httpd
```
```bash
tail /var/log/httpd/error_log
```

```bash
httpd -V
```

on peut demander à curl de rendre un résultat sur le serveur Web. En effet, le dossier par défaut des pages à servir est `/var/www/html`. En l'absence d'un fichier d'index par défaut, une page "noindex" est servie à partir de l'emplacement `/usr/share/httpd/`.

#### GET HTTP

```bash
curl -G http://127.0.0.1
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title>Test Page for the Apache HTTP Server on Fedora</title>
    ...
```

#### HEAD HTTP

```bash
echo "OK" > /var/www/html/test
```
```bash
curl -I http://127.0.0.1/
HTTP/1.1 200 OK
Date: Sun, 18 Nov 2018 12:07:14 GMT
Server: Apache/2.4.34 (Fedora)
Last-Modified: Sun, 18 Nov 2018 12:07:10 GMT
ETag: "3-57aef3d7c776a"
Accept-Ranges: bytes
Content-Length: 3
Content-Type: text/html; charset=UTF-8
```
```bash
curl -G http://127.0.0.1/test
OK
```

#### Configuration courante

On sera curieux d'examiner la configuration du serveur Web située dans l'emplacement `/etc/httpd`.

```bash
egrep -v '^$|^[[:blank:]]*#' /etc/httpd/conf/httpd.conf
ServerRoot "/etc/httpd"
Listen 80
Include conf.modules.d/*.conf
User apache
Group apache
ServerAdmin root@localhost
<Directory />
    AllowOverride none
    Require all denied
</Directory>
DocumentRoot "/var/www/html"
<Directory "/var/www">
    AllowOverride None
    Require all granted
</Directory>
<Directory "/var/www/html">
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>
<IfModule dir_module>
    DirectoryIndex index.html
</IfModule>
<Files ".ht*">
    Require all denied
</Files>
ErrorLog "logs/error_log"
LogLevel warn
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common
    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>
    CustomLog "logs/access_log" combined
</IfModule>
<IfModule alias_module>
    ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
</IfModule>
<Directory "/var/www/cgi-bin">
    AllowOverride None
    Options None
    Require all granted
</Directory>
<IfModule mime_module>
    TypesConfig /etc/mime.types
    AddType application/x-compress .Z
    AddType application/x-gzip .gz .tgz
    AddType text/html .shtml
    AddOutputFilter INCLUDES .shtml
</IfModule>
AddDefaultCharset UTF-8
<IfModule mime_magic_module>
    MIMEMagicFile conf/magic
</IfModule>
EnableSendfile on
IncludeOptional conf.d/*.conf
```

#### Hôtes virtuels

On s'intéressera au concept [d'hôte virtuel](https://linux.goffinet.org/31_services_apache_http_server/#7-serveurs-virtuels-par-nom).

### 1.4. Base de données

#### Tests

Mariadb :

```bash
dnf install mariadb-server
```
```bash
systemctl start mariadb.service
systemctl enable mariadb.service
```

```bash
systemctl status mariadb.service
mysql -V
```

```bash
ss -tlp | egrep 'http|mysql'
LISTEN   0         80                        *:mysql                  *:*        users:(("mysqld",pid=4972,fd=37))
LISTEN   0         128                       *:http                   *:*        users:(("httpd",pid=6206,fd=4),("httpd",pid=5457,fd=4),("httpd",pid=5456,fd=4),("httpd",pid=5455,fd=4),("httpd",pid=5201,fd=4))
```

#### mysql_secure_installation

Avant de l'utiliser, il est de bonne pratique de sécuriser un service de base de données MYSQL.

```bash
mysql_secure_installation
```

```bash
NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n] Y
New password:
Re-enter new password:
Password updated successfully!
Reloading privilege tables..
 ... Success!


By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] y
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
```

### 1.5. Installation de PHP

```bash
dnf install php php-common
```
```bash
dnf install php php-common php-mysqlnd php-gd php-imap php-xml php-cli php-opcache php-mbstring
```

```bash
systemctl restart httpd
cd /var/www/html
echo "<?php phpinfo(); ?>" >> info.php
curl http://127.0.0.1/info.php
```

Examen de la page `info.php`.

![info.php](/images/phpinfo-fedora27-lamp.jpg)

### 1.6. Problématiques rencontrées

[Dépot Remi](https://blog.remirepo.net/pages/Presentation) : https://blog.remirepo.net/pages/Config

#### PHP-FPM

PHP-FPM : voir [Utiliser Apache avec PHP-FPM](https://villalard.net/utiliser-apache-avec-php-fpm)

```bash
curl http://127.0.0.1/info.php
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>503 Service Unavailable</title>
</head><body>
<h1>Service Unavailable</h1>
<p>The server is temporarily unable to service your
request due to maintenance downtime or capacity
problems. Please try again later.</p>
</body></html>
```

Au lieu d'obtenir la "belle" page info.php, on obtient un message d'erreur **503 Service Unavailable** qui renseigne une erreur du côté du serveur ([Codes de retour HTTP](https://linux.goffinet.org/30_services_web/#74-codes-de-retour))

```bash
tail /var/log/httpd/error_log -n2
[Sun Nov 18 12:25:52.916813 2018] [proxy:error] [pid 5207:tid 140606827362048] (2)No such file or directory: AH02454: FCGI: attempt to connect to Unix domain socket /run/php-fpm/www.sock (*) failed
[Sun Nov 18 12:25:52.916891 2018] [proxy_fcgi:error] [pid 5207:tid 140606827362048] [client 127.0.0.1:36686] AH01079: failed to make connection to backend: httpd-UDS
```

Les logs httpd nous indiquent une erreur php-fpm.

```bash
ls /run/php-fpm/www.sock
ls: cannot access '/run/php-fpm/www.sock': No such file or directory
[root@devlab90 html]# ls /run/php-fpm
ls: cannot access '/run/php-fpm': No such file or directory
```

Ce fichier `/run/php-fpm/www.sock` n'existe pas.

```bash
tail -n3 /var/log/php-fpm/error.log
[18-Nov-2018 12:25:50] ERROR: FPM initialization failed
[18-Nov-2018 12:28:15] ERROR: [pool www] failed to read the ACL of the socket '/run/php-fpm/www.sock': Operation not supported (95)
[18-Nov-2018 12:28:15] ERROR: FPM initialization failed
```

```bash
sed -i 's/listen.acl_users/;listen.acl_users/g' /etc/php-fpm.d/www.conf
```

En commentant la ligne qui contient `listen.acl_users`, le service redémarre.

```bash
systemctl start php-fpm
systemctl status php-fpm
```

```bash
curl http://127.0.0.1/info.php
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>503 Service Unavailable</title>
</head><body>
<h1>Service Unavailable</h1>
<p>The server is temporarily unable to service your
request due to maintenance downtime or capacity
problems. Please try again later.</p>
</body></html>
```

Mais l'erreur serveur ne disparaît qu'en fixant les droits de l'utilisateur apache sur le fichier du pool PHP-FPM `/run/php-fpm/www.sock`.

```bash
chown apache:apache /run/php-fpm/www.sock
```

```bash
curl http://127.0.0.1/info.php
```

#### Pare-feu

Comment joindre le serveur de l'extérieur ?

```bash
ip=$(curl -s -G http://ipinfo.io/ip)
url="http://www.${ip}.xip.io/"
```

```bash
echo $url
```

Le stack est-il accessible de l'extérieur ? En Fedora dans lequel le pare-feu est activé par défaut, probablement.

```bash
firewall-cmd --list-services
```

Il est nécessaire d'ouvrir le pare-feu, par exemple en ajoutant le service "http" au profil de filtrage par défaut "public".

```bash
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --reload
```
Comment pourrait-on tester le site sans ouvrir le pare-feu, uniquement avec une connexion SSH ?

En transférant le port local TCP80 sur un port de l'ordinateur qui se connecte ici par exemple TCP8888.

```bash
ssh -L 8888:127.0.0.1:80 root@votres_serveur
```

### 1.7. Téléchargement de Wordpress

Cette étape demande des compétences d'administration "traditionnelle".

```bash
dnf install wget
wget http://wordpress.org/latest.tar.gz
tar xvfz latest.tar.gz -C /var/www/html/
```

### 1.8. Création de la base de données de Wordpress

La procédure consiste à se connecter à la base de données en tant qu'utilisateur "root" de la base de données et à encoder les commandes suivantes qui créent un utilisateur avec un mot de passe à modifier ("testadmin208"), qui créent une base de données et qui lient l'utilisateur à la base de donnée.

```bash
mysql -u root -p
```

Dans le shell mysql, voici les commandes à encoder :

```mysql
CREATE USER wpuser@localhost IDENTIFIED BY "testadmin208";
CREATE DATABASE wp_database;
GRANT ALL ON wp_database.* TO wpuser@localhost;
FLUSH PRIVILEGES;
quit
```

### 1.9. Configurer Wordpress

Il s'agit ici d'indiquer les paramètres de la base de données créée dans l'étape précédente dans un fichier `wp-config.php` en se servant du modèle `wp-config-sample.php`.

```bash
cd /var/www/html/wordpress/
cp wp-config-sample.php wp-config.php
```

Ensuite, modifier les paramètres à l'aide de `vi` :

```
define('DB_NAME', 'wp_database');
define('DB_USER', 'wpuser');
define('DB_PASSWORD', 'testadmin208');
define('DB_HOST', 'localhost');
```

### 1.10. Installer Worpdress

La suite de l'installation se déroule dans l'interface Web. Entretemps, le site reste vulnérable.

```bash
curl http://127.0.0.1/wordpress/
```

### 1.11. Nettoyer ses opérations

Le script `clean-lamp.sh` se propose de nettoyer grossièrement ces opérations.

```bash
#! /bin/bash
# clean-lamp.sh
systemctl stop httpd mariadb php-fpm
systemctl disable httpd mariadb php-fpm
dnf -y remove mariadb mariadb-server httpd php-fpm
rm -rf /var/lib/mysql
rm -r /etc/my.cnf
rm -r ~/.my.cnf
rm -rf /var/www/html/*
firewall-cmd --zone=public --permanent --remove-service=http
firewall-cmd --reload
```

## 2. Améliorations et automatisations

Dans cet exercice, on reprendra les opérations dans une perspective d'automation qui regroupe les tâches dans des étapes distinctes. Un seul mot de passe est choisi "Yj7tXc1Ml". La perspective reste séquentielle.

On tentera de rassembler les opérations logiques en étapes : installation, configuration, lancement, test, ... La procédure d'installation de Wordpress peut elle-même être divisée en quelques étapes.

* Installation, configuration et lancement du stack LAMP
* Création de la base de donnée
* Test des services
* Installation de Wordpress

### 2.1. Installation, configuration et lancement du stack LAMP

En regroupes les tâches d'installation, de configuration et de lancement des services LAMP, la configuration du pare-feu.

```bash
# Choose a password for root and wpuser database : "Yj7tXc1Ml"
# LAMP Stack installation and dependencies
dnf -y install httpd mariadb-server php php-mysqlnd php-json wget
# Configure php-fpm
sed -i 's/listen.acl_users/;listen.acl_users/g' /etc/php-fpm.d/www.conf
# Enable and start services
systemctl enable httpd mariadb php-fpm
systemctl start httpd mariadb php-fpm
chown apache:apache /run/php-fpm/www.sock
# Open the HTTP port TCP 80
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --reload
```

### 2.2. Création de la base de donnée

La base de données Wordpress est créée et configurée après avoir sécurisé le service.

```bash
# See https://stackoverflow.com/questions/24270733/automate-mysql-secure-installation-with-echo-command-via-a-shell-script
# See https://gist.github.com/Mins/4602864
# mysql_secure_installation as model
# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('Yj7tXc1Ml') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Create wpuser
mysql -e "CREATE USER wpuser@localhost IDENTIFIED BY 'Yj7tXc1Ml';"
# Create wp_database
mysql -e "CREATE DATABASE wp_database;"
# Fix wpuser rights on wp_database
mysql -e "GRANT ALL ON wp_database.* TO wpuser@localhost;"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
echo 'root password : Yj7tXc1Ml' > /root/.wpsecrets
echo 'wpuser password : Yj7tXc1Ml' >> /root/.wpsecrets
chmod 600 /root/.wpsecrets
```

Remarquez que le mot de passe est enregistré dans le fichier caché `/root/.wpsecrets`

### 2.3. Tests des services

```bash
# Test Apache
if [ $(curl -s -I 127.0.0.1 | grep -q 'Server: Apache/2.4.34 (Fedora)' ; echo $?) == '0' ] ; then
echo "Apache is working" ; else
echo "Apache is NOT working" ; fi
```

```bash
# Test PHP
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
if [ $(curl -s -G http://127.0.0.1/info.php | grep -q 'phpinfo' ; echo $?) == '0' ] ; then
echo "PHP is working" ; else
echo "PHP is NOT working" ; fi
#rm -f /var/www/html/info.php
```

### 2.4. Installation de Wordpress

```bash
# Download Wordpress lastest version
wget http://wordpress.org/latest.tar.gz
tar xvfz latest.tar.gz -C /var/www/html/
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sed -i 's/database_name_here/wp_database/g' /var/www/html/wordpress/wp-config.php
sed -i 's/username_here/wpuser/g' /var/www/html/wordpress/wp-config.php
sed -i 's/password_here/Yj7tXc1Ml/g' /var/www/html/wordpress/wp-config.php
# Configure your application
echo "Go to http://$(curl -s https://ipinfo.io/ip).xip.io/wordpress/ to configure your application"
```

## 3. Script fonctionnel

L'exercice précédent consistait à reprendre les lignes de commandes manuelles et à les automatiser.

Toutefois, on peut suggérer quelques optimisations qui rendraient la procédure plus évolutive et plus robuste.

* Les étapes logiques pourraient être présentées sous forme de fonctions.
* Toute une série de paramètres pourraient subir une mise en variable.
* Enfin la seconde étape d'installation de Wordpress semble peu robuste. On proposera ici d'utiliser wp-cli.

Voici un troisième exercice qui illustre ces optimisations.

### 3.1. Mise en variables

L'adresse IP du site, son [FQDN](https://fr.wikipedia.org/wiki/Fully_qualified_domain_name), son titre, les utilisateurs "admin" (utilisateur de gestion) et "dbuser" (utilisateur de la base de données), l'emplacement de l'application, les mots de passe (générés de manière aléatoire) sont susceptibles d'être mis en paramètres.

```bash
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

```

### 3.2. Installation des logiciels

Installation des logiciels et adaptation du fichier `/etc/php-fpm.d/www.conf`.

```bash
software_installation() {
# LAMP Stack installation and dependencies
dnf -y install httpd mariadb-server php php-mysqlnd php-json curl python
# Work around php-fpm config due the lack of apache config
sed -i 's/listen.acl_users/;listen.acl_users/g' /etc/php-fpm.d/www.conf
}
```

### 3.3. démarrage des services

On donnera les droits aux utilisateur et groupe `apache` sur le fichier `/run/php-fpm/www.sock`.

```bash
enable_start_services() {
# Enable and start services
systemctl enable httpd mariadb php-fpm
systemctl start httpd mariadb php-fpm
chown apache:apache /run/php-fpm/www.sock
}
```

### 3.4. Ouverture du par-feu

```bash
open_firewall() {
# Open the HTTP port TCP 80
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --reload
}
```


### 3.5. Sécuriser Mariabd et le configurer pour Wordpress

Il s'agit de profiter de l'absence de mot de passe sur le compte root pour créer la base et l'utilisateur Wordpress.

```bash
wordpress_database_creation() {
# Create dbuser
mysql -e "CREATE USER ${dbuser}@localhost IDENTIFIED BY '${dbuser_password}';"
# Create wp_database
mysql -e "CREATE DATABASE wp_database;"
# Fix dbuser rights on wp_database
mysql -e "GRANT ALL ON wp_database.* TO ${dbuser}@localhost;"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
}
```

```bash
mysql_secure() {
# mysql_secure_installation as model
# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('${dbroot_password}') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
}
```

### 3.6. Enregistrement des mots de passe

```bash
store_passwords() {
echo "dbroot_password=${dbroot_password}" > /root/.wpsecrets
echo "dbuser_password=${dbuser_password}" >> /root/.wpsecrets
echo "admin_password=${admin_password}" >> /root/.wpsecrets
chmod 600 /root/.wpsecrets
}
```

### 3.7. Tests du stack

```bash
test_stack() {
# Test Apache
if [ $(curl -s -I 127.0.0.1 | grep -q 'Server: Apache/2.4.34 (Fedora)' ; echo $?) == '0' ] ; then
echo "Apache is working" ; else
echo "Apache is NOT working" ; break ; fi
apachectl -V

# Test PHP
echo "<?php phpinfo(); ?>" > ${application_path}/info.php
if [ $(curl -s -G http://127.0.0.1/info.php | grep -q 'phpinfo' ; echo $?) == '0' ] ; then
echo "PHP is working" ; else
echo "PHP is NOT working" ; break ; fi
#rm -f ${application_path}/info.php
}
```

## 4. WP-CLI

WP-CLI est un ensemble d’outils en ligne de commande pour gérer les installations WordPress. Vous pouvez mettre à jour les extensions, configurer des installations multi-site et beaucoup plus sans avoir recours à un navigateur web.

Voir [WP-CLI: Interface en ligne de commande pour WordPress](https://wp-cli.org/fr/).

Toutes les opérations sur Wordpress en ligne de commande :

* Téléchargement / mise à jour
* Installation, configuration, création de base de données
* Installation de thèmes, de plugins, création et gestion des utilisateurs
* ...

[Guide de démarrage wp-cli](https://make.wordpress.org/cli/handbook/quick-start/)

[Installation wp-cli](https://make.wordpress.org/cli/handbook/installing/)

### 4.1 Installation de wp-cli

```bash
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar ; mv wp-cli.phar /usr/local/bin/wp
```

### 4.2. Vérifier le fonctionnement de wp-cli

```bash
# Check if wp-cli is working
if [ $(wp --info > /dev/null ; echo $?) == '0' ] ; then
echo "wp-cli is working" ; else
echo "wp-cli is NOT working" ; fi
```

### 4.3. Télécharger Worpdress

[wp core download](https://developer.wordpress.org/cli/commands/core/download/)

```bash
# Download Wordpress
wp core download --path=${application_path} --locale=fr_FR
```

### 4.4. Création du fichier de configuration

[wp config create](https://developer.wordpress.org/cli/commands/config/create/)

```bash
# Create wp-config.php
wp config create --dbname=wp_database \
--dbuser=${dbuser} \
--dbpass=${dbuser_password} \
--path=${application_path}
```

### 4.4. Créer la base de données Wordpress

La base de données a été créée dans une étape précédente. Ici, pour documentation avec wp-cli.

[wp db create](https://developer.wordpress.org/cli/commands/db/create/)

### 4.6. Installation de Wordpress

[wp core install](https://developer.wordpress.org/cli/commands/core/install/)

```bash
# Installation Wordpress
wp core install --url=${site_url} \
--title="${site_title}" \
--admin_user=${admin_user} \
--admin_password=${admin_password} \
--admin_email=${admin_email} \
--path=${application_path}
```

### 4.7. Mise-à-jour de tous les plugins dans leur dernière version

```bash
# Update plugins to their latest version
wp plugin update --all --path=${application_path}
```

### 4.8. Affichage des informations

```bash
echo "Go to ${site_url} to access to your application"
```

### 4.9. Résumé du déploiement de Wordpress

```bash
wpcli_installation() {
# Installation de wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar ; mv wp-cli.phar /usr/local/bin/wp

# Check if wp-cli is working
if [ $(wp --info > /dev/null ; echo $?) == '0' ] ; then
echo "wp-cli is working" ; else
echo "wp-cli is NOT working" ; fi
}

wordpress_installation() {
# Download Wordpress
wp core download --path=${application_path} --locale=fr_FR

# Create wp-config.php
wp config create --dbname=wp_database \
--dbuser=${dbuser} \
--dbpass=${dbuser_password} \
--path=${application_path}

# Installation
wp core install --url=${site_url} \
--title="${site_title}" \
--admin_user=${admin_user} \
--admin_password=${admin_password} \
--admin_email=${admin_email} \
--path=${application_path}

# Update plugins to their latest version
wp plugin update --all --path=${application_path}
}

print_end_message() {
# Acces to your application
echo "Go to ${site_url} to access to your application"
}
```

### 4.10. Programme principal

```bash
software_installation
enable_start_services
open_firewall
store_passwords
test_stack
wordpress_database_creation
mysql_secure
wpcli_installation
wordpress_installation
print_end_message

```

### 4.11. Améliorations et optimisations

* Améliorer la gestion des erreurs
* Configuration en Vhosts
* Dépendance sendmail
* HTTPS / Let's Encrypt
* Renforcement sécuritaire de Wordpress
* SELINUX

## 5. Déploiement de la solution sur Centos 7 et Ubuntu

[How to install Apache, PHP 7.2 and MySQL on CentOS 7.4 (LAMP)](https://www.howtoforge.com/tutorial/centos-lamp-server-apache-mysql-php/) et [How To Install Linux, Apache, MySQL, PHP (LAMP) stack on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04).

Sur base de cette documentation sommaire, il est demandé d'adapter le script à la distribution Centos7 et Ubuntu.

```
[ -f /etc/fedora-release ] && echo "do someting on fedora"
[ -f /etc/centos-release ] && echo "do someting on centos7"
[ -f /etc/lsb-release ] && echo "do someting on ubuntu"
```

### 5.1. Déploiement Centos7

A peu de choses près, il s'agit s'utiliser la commande `yum` plutôt que `dnf`, sauf que `php-fpm` n'est pas installé par défaut.

```bash
centos_software_installation() {
yum -y install httpd mariadb-server php php-common php-mysqlnd php-gd php-imap php-xml php-cli php-opcache php-mbstring php-json firewalld
}

centos_enable_start_services() {
systemctl enable httpd mariadb firewalld
systemctl start httpd mariadb firewalld
}
```

[How to Install FastCGI PHP-FPM on CentOS 7](https://www.webhostinghero.com/blog/install-fastcgi-php-fpm-on-centos-7/)

### 5.2. Déploiement sur Ubuntu

```bash
sudo apt update
sudo -y apt install apache2 php libapache2-mod-php mariadb-server php-mysql php-curl php-gd php-intl php-json php-mbstring php-xml php-zip
sudo systemctl enable apache2
sudo systemctl enable mysql
sudo systemctl start apache2
sudo systemctl start mysql
```

Voici ce que cela donne dans le script.

```bash
ubuntu_software_installation() {
apt update && apt -yy upgrade
apt -yy install apache2 php libapache2-mod-php mariadb-server php-mysql php-curl php-gd php-intl php-json php-mbstring php-xml php-zip firewalld
}

ubuntu_enable_start_services() {
systemctl enable apache2 mysql firewalld
systemctl reload apache2 mysql firewalld
rm -rf /var/www/html/index.html
}
```

Par défaut sous Ubuntu, les services installés sont activés et démarrent. Toutefois, il est nécessaire de redémarrer le service Apache.

Notons aussi l'effacement de la page `index.html` associée au "virtual host" par défaut. En effet, dans cette configuration, en dehors de l'indiscrétion créée, elle entrera en concurrence avec la page `index.php` de Wordpress.

### 5.2. Allow-root WP-CLI

Aussi, on remarquera que `wp-cli` n'autorise pas à priori une exécution en tant que root, ce qui nous oblige à ajouter la directive `--allow-root` sur les commandes concernées.

```bash
wordpress_installation() {
# Download Wordpress
wp core download --path=${application_path} --locale=fr_FR --allow-root

# Create wp-config.php
wp config create --dbname=wp_database \
--dbuser=${dbuser} \
--dbpass=${dbuser_password} \
--path=${application_path} \
--allow-root

# Installation
wp core install --url=${site_url} \
--title="${site_title}" \
--admin_user=${admin_user} \
--admin_password=${admin_password} \
--admin_email=${admin_email} \
--path=${application_path} \
--allow-root

# Update plugins to their latest version
wp plugin update --all --path=${application_path} --allow-root
}

```

### 5.3 Configuration virtual host

Il serait de bonne pratique de configurer un "virtual host" supplémentaire et de désactiver qui est installé par défaut. Ici, juste pour mémoire.

`/etc/apache2/sites-available/example.com.conf`

```apache
<VirtualHost *:80>
	ServerName example.com
	ServerAlias www.example.com
	DocumentRoot "/var/www/example"
	<Directory "/var/www/example">
		Options FollowSymLinks
		AllowOverride all
		Require all granted
	</Directory>
	ErrorLog /var/log/apache2/error.example.com.log
	CustomLog /var/log/apache2/access.example.com.log combined
</VirtualHost>
```

```bash
sudo a2ensite example.com
sudo systemctl reload apache2
```

### 5.4. Appel aux fonctions selon la distribution

Quel critère utiliser pour conditionner l'exécution des fonctions `fedora_*`, `centos_*` ou `ubuntu_*` ?

Chaque distribution dispose de fichiers qui identifie son origine :

```bash
if [ -f /etc/fedora-release ] ; then
fedora_software_installation
fedora_enable_start_services
elif [ -f /etc/centos-release ] ; then
centos_software_installation
centos_enable_start_services
elif [ -f /etc/lsb-release ] ; then
ubuntu_software_installation
ubuntu_enable_start_services
fi
open_firewall
wordpress_database_creation
mysql_secure
store_passwords
test_stack
wpcli_installation
wordpress_installation
print_end_message
```

## 6. Support HTTPS Let's Encrypt

* Configuration Apache
* Let's Encrypt Cert-Bot
* Cron

## 7. Déploiement Wordpress Haute Disponiblité

Inspiré de [Ansible playbooks to install Wordpress in a HA configuration on IBM Cloud IaaS](https://github.com/stevestrutt/wordpress_ansible_ibmcloud)

![Single site deployment, using 3 Centos 7.x VSIs and a Cloud Load Balancer](https://developer.ibm.com/recipes/wp-content/uploads/sites/41/2018/08/WordpressCLB.png)

[Single site deployment, using 3 Centos 7.x VSIs and a Cloud Load Balancer](https://developer.ibm.com/recipes/tutorials/high-availability-deployment-of-wordpress-using-ansible/)

![Dual site deployment](https://developer.ibm.com/recipes/wp-content/uploads/sites/41/2018/08/WordpressGLB.png)

[Dual site deployment](https://developer.ibm.com/recipes/tutorials/high-availability-deployment-of-wordpress-using-ansible/)

## 8. Déploiement sur Docker

Stack LAMP/Wordpres sur Docker.

[Docker pour ma stack LAMP](https://blog.kulakowski.fr/post/docker-pour-ma-stack-lamp)

![Schéma d’architecture simplifié de la stack LAMP sous Docker](https://blog.kulakowski.fr/wp-content/uploads/2018/04/architecture_docker_light.png)

![Schéma d’architecture complet de la stack LAMP sous Docker](https://blog.kulakowski.fr/wp-content/uploads/2018/04/architecture_docker-768x724.png)

Architecture Docker Compose

```yaml
version: '2.1'

################################################################### All services
services:
  httpd:
    container_name: httpd
    image: llaumgui/httpd24
    build:
      context: build/httpd/2.4/
    restart: always
    volumes:
     - /etc/localtime:/etc/localtime:ro
     - /docker/volumes/www:/var/www/
     - /docker/conf/httpd/vhost.d:/usr/local/apache2/conf/vhost.d:ro
     - /docker/conf/httpd/ssl:/usr/local/apache2/ssl:ro
    ports:
     - "80:80"
     - "443:443"

  php:
    container_name: php
    image: llaumgui/php:7.2-fpm
    build:
      context: build/php-fpm/7.2/
      args:
        DOCKER_PHP_ENABLE_APCU: 'on'
        DOCKER_PHP_ENABLE_COMPOSER: 'on'
        DOCKER_PHP_ENABLE_LDAP: 'off'
        DOCKER_PHP_ENABLE_MEMCACHED: 'off'
        DOCKER_PHP_ENABLE_MONGODB: 'off'
        DOCKER_PHP_ENABLE_MYSQL: 'on'
        DOCKER_PHP_ENABLE_POSTGRESQL: 'off'
        DOCKER_PHP_ENABLE_REDIS: 'on'
        DOCKER_PHP_ENABLE_SYMFONY: 'off'
        DOCKER_PHP_ENABLE_XDEBUG: 'off'
        DOCKER_USER_UID: 1001
        DOCKER_USER_GID: 1001
    restart: always
    volumes:
     - /etc/localtime:/etc/localtime:ro
     - /docker/volumes/www:/var/www/
    expose:
     - 9000
    ports:
     - "127.0.0.1:9000:9000"
    depends_on:
     - httpd
     - mariadb
     - redis
    links:
     - mariadb:database
    extra_hosts:
     - "mailserver:172.18.0.1"

  mariadb:
    container_name: mariadb
    image: mariadb:10.1
    restart: always
    env_file:
     - /docker/conf/mariadb.env
    volumes:
     - /etc/localtime:/etc/localtime:ro
     - /docker/volumes/mariadb:/var/lib/mysql
     - /docker/volumes/mysqldump:/mysqldump
    expose:
     - 3306
    ports:
     - "127.0.0.1:3306:3306"

  redis:
    container_name: redis
    image: redis:4-alpine
    restart: always
    volumes:
     - /etc/localtime:/etc/localtime:ro
    expose:
     - 6379
```

## 9. Approvisionnement Ansible

Stack LAMP/wordpress à partir d'Ansible.
