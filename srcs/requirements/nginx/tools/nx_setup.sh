#!/bin/sh
# set -ex: In case of some command failing.
set -e
apt-get update
apt-get upgrade -y
apt-get install -y openssl nginx

rm -rf /var/lib/apt/lists/*
