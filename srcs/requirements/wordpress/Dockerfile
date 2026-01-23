FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
	default-mysql-client \
    php-gd \
    php-curl \
    php-zip \
    php-xml \
    php-mbstring \
    php-intl \
    unzip \
    curl \
    ca-certificates && \
	rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's|listen = .*|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf
RUN curl 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar' -o /usr/local/bin/wp
EXPOSE 9000

COPY ./tools /usr/local/bin

RUN set -e \
 && chmod +x /usr/local/bin/* \
 && command -v bash >/dev/null

ENTRYPOINT ["run.sh"]
CMD ["php-fpm8.2", "-F"]
