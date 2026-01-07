#!/bin/bash
set -e

MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "First run - initializing database..."
    
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    pid="$!"
 
    sleep 5
	mariadb <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
	EOSQL
    kill "$pid"
    wait "$pid"
fi
exec "$@"
