#!/bin/bash
set -eu

export HTTP_HOST=localhost
export MARIA_DB_PASSWORD=$(cat /run/secrets/db_password)
export WP_PASSWORD=$(cat /run/secrets/wp_admin_password)
required_vars=(
	"MARIA_DB_PASSWORD"
	"WP_PASSWORD"
	"MARIA_DATABASE_NAME"
	"MARIA_DB_USER"
	"MARIA_DB_HOST"
	"URL"
	"SITE_TITLE"
	"WP_USER"
	"EMAIL"
)

check_required_var() {
    local var_name="$1"
    local var_value="${!var_name}"
    
    if [ -z "$var_value" ]; then
        echo "$var_name is not set yet! please set it up, then retry"
        exit 1
    fi
}

for var in "${required_vars[@]}"; do
    check_required_var "$var"
done
exit 0
