FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y openssl nginx && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /etc/nginx/certs/ /usr/share/nginx/errors/

EXPOSE 443
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/404.html /usr/share/nginx/errors/

COPY ./tools /usr/local/bin

RUN set -e \
 && chmod +x /usr/local/bin/*.sh \
 && command -v bash >/dev/null

ENTRYPOINT ["run.sh"]
CMD ["nginx", "-g", "daemon off;"]
