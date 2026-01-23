#!/bin/bash
set -eu
cd /var/www/html

check_env.sh

export HTTP_HOST=localhost
MARIA_DB_PASSWORD=$(cat /run/secrets/db_password)
WP_PASSWORD=$(cat /run/secrets/wp_admin_password)
if [ ! -f wp-includes/version.php ]; then
    echo "Downloading WordPress :0..."
    wp core download --allow-root
fi
if [ ! -f wp-config.php ]; then
    echo "creating config for WordPress :0..."
	wp config create \
		--dbname="$MARIA_DATABASE_NAME" \
		--dbuser="$MARIA_DB_USER" \
		--dbhost="$MARIA_DB_HOST" \
		--dbpass="$MARIA_DB_PASSWORD" \
		--allow-root
fi

if ! wp core is-installed --allow-root ; then 
    echo "installing WordPress :0..."
	wp core install \
        --url="$URL" \
        --title="$SITE_TITLE" \
        --admin_user="$WP_USER" \
        --admin_password="$WP_PASSWORD" \
        --admin_email="$EMAIL" \
		--skip-email \
        --allow-root
	chown -R www-data:www-data .
fi
echo "Wordpress entry: OK"
exec "$@"
