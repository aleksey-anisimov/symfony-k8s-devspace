#!/bin/sh

mkdir -p /var/www/symfony/var/cache
mkdir -p /var/www/symfony/var/log

#chown www-data:www-data -R /var/www/symfony

chmod 777 -R /var/www/symfony/var/cache
chmod 777 -R /var/www/symfony/var/log

# Start PHP
php-fpm -D
# Start SSH
/usr/sbin/sshd -D