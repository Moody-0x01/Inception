FROM debian:12

COPY fpm_setup.sh /
RUN chmod +x /fpm_setup.sh && /fpm_setup.sh
RUN rm -rf /fpm_setup.sh

EXPOSE 9000
CMD ["php-fpm8.2", "-F"]
