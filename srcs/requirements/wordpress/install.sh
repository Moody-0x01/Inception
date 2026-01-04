#!/bin/bash
cd /var/www/html

if wp core is-installed; then 
	wp core download --allow-root
	chown -R www-data:www-data .
fi
exec php-fpm8.2 -F
