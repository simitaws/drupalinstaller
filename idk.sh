#!/bin/bash

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