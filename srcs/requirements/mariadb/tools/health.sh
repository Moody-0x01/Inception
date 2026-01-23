#!/bin/bash
set -e
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
	echo "health_check: MYSQL_ROOT_PASSWORD is not set yet! please set it up, then retry"
	exit 1
fi

mysqladmin ping \
  -uroot \
  -p"$MYSQL_ROOT_PASSWORD" \
  --protocol=socket \
  >/dev/null 2>&1 \
  || exit 1
