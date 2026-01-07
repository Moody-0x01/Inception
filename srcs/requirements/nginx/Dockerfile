FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /etc/nginx/certs/
COPY ./tools/re_cert.sh /
COPY ./tools/nx_setup.sh /

RUN chmod +x /*.sh && /nx_setup.sh && /re_cert.sh
RUN rm -rf /nx_setup.sh /re_cert.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
