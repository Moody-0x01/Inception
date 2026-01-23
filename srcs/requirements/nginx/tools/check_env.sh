#!/bin/bash
set -eu

# Will be used to generate certs by gen_certs.sh
export EXPIRATION=365
export CRTS_DIR=/etc/nginx/certs
export DOMAIN="lazmoud.42.fr"

if [[ ! -f "$CRTS_DIR/$DOMAIN.key " || ! -f "$CRTS_DIR/$DOMAIN.crt" ]]; then
    echo "certs missing → regenerating both into $CRTS_DIR"
	gen_certs.sh # NOTE: Generating certs if they dont exist
fi
echo "env_check: OK"
