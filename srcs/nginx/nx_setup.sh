#!/bin/sh
# set -ex: In case of some command failing.
apt-get update
apt-get upgrade -y
apt-get install -y \
	apt-utils \
    curl \
    gnupg2 \
    ca-certificates \
    lsb-release \
    debian-archive-keyring \
	openssl

curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    https://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list

echo "Package: *" >> /etc/apt/preferences.d/99nginx
echo "Pin: origin nginx.org" >> /etc/apt/preferences.d/99nginx
echo "Pin: release o=nginx" >> /etc/apt/preferences.d/99nginx
echo "Pin-Priority: 900" >> /etc/apt/preferences.d/99nginx

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
openssl req -new -newkey rsa:2048 -nodes \
  -keyout yourdomain.key \ -out yourdomain.csr
apt-get update
apt-get install -y nginx
