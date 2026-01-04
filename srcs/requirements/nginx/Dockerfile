FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

COPY nx_setup.sh /
RUN chmod +x /nx_setup.sh && /nx_setup.sh
RUN rm -rf /nx_setup.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY *.html /usr/share/nginx/html
RUN mkdir -p /html /etc/nginx/certs/
COPY ./cert/* /etc/nginx/certs/

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
