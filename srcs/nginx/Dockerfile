FROM debian:12

COPY nx_setup.sh /
RUN chmod +x /nx_setup.sh && /nx_setup.sh
RUN rm -rf /nx_setup.sh
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /html /etc/nginx/certs/
COPY *.html /usr/share/nginx/html
EXPOSE 443 80

# Certs
COPY ./cert/* /etc/nginx/certs/

CMD ["nginx", "-g", "daemon off;"]

