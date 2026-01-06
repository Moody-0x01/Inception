FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
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
    ca-certificates
RUN rm -rf /var/lib/apt/lists/*
RUN sed -i -e 's|listen = .*|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf
RUN curl 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar' -o /bin/wp && chmod +x /bin/wp
COPY ./install.sh /
RUN chmod +x /install.sh

EXPOSE 9000
CMD ["/install.sh"]
