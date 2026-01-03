#!/bin/sh

mkdir -p /home/lazmoud/data/html
cd /home/lazmoud/data/html
curl -o wordpress.tar.gz 'https://wordpress.org/latest.tar.gz'
tar -xzf wordpress.tar.gz --strip-components=1
rm wordpress.tar.gz
