#!/bin/sh
# Comment: This script is intended to be used once u need to refresh the SSL certs
# if they are there then u dont need to run it.
mkdir $CRTS_DIR
openssl req -x509 -new -newkey rsa:2048 -nodes -days $EXPIRATION -keyout $CRTS_DIR/$DOMAIN.key -out $CRTS_DIR/$DOMAIN.crt -subj "/C=MA/ST=Marrakech-Safi/L=BenGuerir/O=42/CN=$DOMAIN"
