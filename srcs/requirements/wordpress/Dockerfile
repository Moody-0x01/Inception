FROM debian:12

COPY wp_setup.sh /
RUN chmod +x /wp_setup.sh && /wp_setup.sh
RUN rm -rf /wp_setup.sh

EXPOSE 9000
CMD ["php-fpm", "-F"]
