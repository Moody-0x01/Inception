#!/bin/sh

apt-get update
apt-get upgrade -y

apt-get install mariadb-server mariadb-client galera-4
