#!/bin/bash
set -eu

DATA_DIR="/var/lib/mysql"
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
required_vars=(
	"MYSQL_PASSWORD"
	"MYSQL_ROOT_PASSWORD"
	"MARIA_DATABASE_NAME"
	"MARIA_DB_USER"
)

check_required_var() {
    local var_name="$1"
    local var_value="${!var_name}"
    
    if [ -z "$var_value" ]; then
        echo "env_check: $var_name is not set yet! please set it up, then retry"
        exit 1
    fi
}

for var in "${required_vars[@]}"; do
    check_required_var "$var"
done
echo "env_check: OK"
exit 0
