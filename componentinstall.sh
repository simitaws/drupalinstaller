#!/bin/bash

sudo apt update
sudo apt full-upgrade -y

sudo apt install -y mariadb-server mariadb-client
sudo apt install php php-{cli,fpm,json,common,mysql,zip,gd,intl,mbstring,curl,xml,pear,tidy,soap,bcmath,xmlrpc}
sudo apt install apache2 libapache2-mod-php
