#!/bin/bash
set -eu
source check_env.sh # NOTE: checking env
echo "NGINX entry: OK"
exec "$@"
