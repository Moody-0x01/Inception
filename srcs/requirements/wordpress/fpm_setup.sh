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

sed -i -e 's|listen = .*|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf # Configure fpm
rm -rf /var/lib/apt/lists/*
