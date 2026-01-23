FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/* && \
	mkdir -p /var/run/mysqld /etc/mysql/mariadb.conf.d/ && \
    chown -R mysql:mysql /var/run/mysqld
EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools /usr/local/bin

RUN set -e \
 && chmod +x /usr/local/bin/*.sh \
 && command -v bash >/dev/null

ENTRYPOINT ["run.sh"]
CMD ["mysqld"]
