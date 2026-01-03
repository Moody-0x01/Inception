#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "First run - initializing database..."
    
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    mysqld --user=mysql &
    pid="$!"
 
    sleep 5
    
    mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mariadb -e "CREATE DATABASE ${MYSQL_DATABASE};"
    
    kill "$pid"
    wait "$pid"
fi
exec "$@"
