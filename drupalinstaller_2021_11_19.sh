#!/bin/bash
clear
echo "Hello $USER"
echo "This is the intellectual property of Oliver Balint"
echo "This script installs Drupal 9 CMS on ubuntu 20.04"
echo "Sript build date:     2021.12.02"
echo "Version:              V.BETA_0"
echo "If you want to commence with this installation please press [ENTRER] or if you want to quit press [CONTROL-C]"
read inp_var

clear

echo "Beginning with installation"
echo "Updating and installing necessary components"

        sudo apt update
        sudo apt full-upgrade -y
        sudo apt install -y mariadb-server mariadb-client
        sudo apt install -y php php-{cli,fpm,json,common,mysql,zip,gd,intl,mbstring,curl,xml,pear,tidy,soap,bcmath,xmlrpc}
        sudo apt install -y apache2 libapache2-mod-php

echo "Mysql setup - please follow the steps "

        sudo mysql_secure_installation

echo "Allow users to log in with root password"
echo "UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE User = 'root'; FLUSH PRIVILEGES; QUIT;"
        
        sudo mysql -u root

echo "Please create a user and a database for drupal"
echo "CREATE DATABASE drupal;  GRANT ALL PRIVILEGES ON drupal.* TO ‘drupal’@’localhost’ IDENTIFIED BY ‘Str0ngDrupaLP@SS’;     FLUSH PRIVILEGES; \q"
        
        mysql -u root -p

echo "Please set desired Memory limit and timezone in the php configaration"
echo "memory_limit = 1024M \n date.timezone = Europe/Budapest"
        
        sudo nano /etc/php/*/apache2/php.ini

echo "installing drupal"

        wget https://www.drupal.org/download-latest/tar.gz -O drupal.tar.gz
        tar xvf drupal.tar.gz
        rm -f drupal*.tar.gz
        sudo mv drupal-*/  /var/www/html/drupal

echo "checking if drupal is in apache dir"

        ls /var/www/html/drupal
        sudo chown -R www-data:www-data /var/www/html/
        sudo chmod -R 755 /var/www/html/

clear
#echo "###################################################################################################################################################################################"

echo "please create a configuration for your drupal site"
echo "This is an example of how the configuration should look like"
echo "<VirtualHost *:80>
     ServerName mysite.com
     ServerAlias www.mysite.com
     ServerAdmin admin@mysite.com
     DocumentRoot /var/www/html/drupal/

     CustomLog ${APACHE_LOG_DIR}/access.log combined
     ErrorLog ${APACHE_LOG_DIR}/error.log

      <Directory /var/www/html/drupal>
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
            RewriteEngine on
            RewriteBase /
            RewriteCond %{REQUEST_FILENAME} !-f
            RewriteCond %{REQUEST_FILENAME} !-d
            RewriteRule ^(.*)$ index.php?q=$1 [L,QSA]
   </Directory>
</VirtualHost>"
echo "press [ENTER] to continue"
read inp_var

        sudo nano /etc/apache2/sites-available/drupal.conf
        sudo apachectl -t
        sudo a2dismod mpm_event
        sudo a2enmod mpm_prefork
        sudo sudo a2enmod php7.4
        sudo a2enmod rewrite
        sudo a2ensite drupal.conf
        systemctl restart apache2


echo "Installation finished!"
echo "Press enter to confirm"
read inp_var
clear
echo "Go to a webbrowser and look up the specified ip of drupal installation, follow the steps from there!"
