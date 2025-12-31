#!/bin/sh

apt-get update
apt-get upgrade -y
apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    php-gd \
    php-curl \
    php-zip \
    php-xml \
    php-mbstring \
    php-intl \
    unzip \
    curl \
    ca-certificates \

rm -rf /var/lib/apt/lists/*
sed -i -e 's|listen = .*|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf
mkdir -p /var/www/html
cd /var/www/html
curl -o wordpress.tar.gz 'https://wordpress.org/latest.tar.gz'
tar -xzf wordpress.tar.gz --strip-components=1
rm wordpress.tar.gz
