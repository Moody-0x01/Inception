#!/bin/bash
set -e
cd /var/www/html
sleep 10
if [ ! -f wp-includes/version.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
fi
if [ ! -f wp-config.php ]; then
	wp config create \
		--dbname="$WORDPRESS_DB_NAME" \
		--dbuser="$WORDPRESS_DB_USER" \
		--dbpass="$WORDPRESS_DB_PASSWORD" \
		--dbhost="$WORDPRESS_DB_HOST" \
		--allow-root
fi
if ! wp core is-installed --allow-root ; then 
	wp core install \
		--allow-root \
        --url="$URL" \
        --title="$SITE_TITLE" \
        --admin_user="$WP_USER" \
        --admin_password="$WP_PASSWORD" \
        --admin_email="$EMAIL" \
		--skip-email \
        --allow-root
	chown -R www-data:www-data .
fi

exec php-fpm8.2 -F
