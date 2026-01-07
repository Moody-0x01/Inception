FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld

EXPOSE 3306

COPY ./tools/mr_setup.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
USER mysql
CMD ["mysqld", "--bind-address=0.0.0.0"]
