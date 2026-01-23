#!/bin/bash
set -eu

echo "[!] MariaDB setup"
check_env.sh

DATADIR="/var/lib/mysql"
DB_PATH=$DATADIR/$MARIA_DATABASE_NAME
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

if [ ! -f "$DB_PATH" ]; then
    echo "[!] Initializing database..."
	if [ -d "$DATADIR" ]; then
		echo "[!] Wiping MariaDB data directory: $DATADIR"
		rm -rf "$DATADIR"/*
	fi
    mysql_install_db
    mysqld --skip-networking &
    pid="$!"
	sleep 5
    mysql -u root <<EOSQL
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
		CREATE DATABASE IF NOT EXISTS \`${MARIA_DATABASE_NAME}\`;
        CREATE USER IF NOT EXISTS '${MARIA_DB_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
		CREATE USER 'health'@'localhost' IDENTIFIED VIA unix_socket;
		GRANT USAGE ON *.* TO 'health'@'localhost';
		GRANT ALL PRIVILEGES ON \`${MARIA_DATABASE_NAME}\`.* TO '${MARIA_DB_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL
	mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
    wait "$pid"
	echo "$MARIA_DATABASE_NAME Db was created succefully for $MARIA_DB_USER"
else
	echo "$MARIA_DATABASE_NAME Db already exists for $MARIA_DB_USER"
fi
echo "MARIADB entry: OK"
exec "$@"
