#!/bin/bash
# takes two paramters, the domain name and the email to be associated with the certificate
DOMAIN="server.fls.red"
EMAIL="suputra@mail.com"

echo DOMAIN=${DOMAIN} >> .env
echo EMAIL=${EMAIL} >> .env

# Phase 1
docker compose -f ./docker-compose-initiate.yml up -d nginx-temp-server.fls.red
docker compose -f ./docker-compose-initiate.yml up certbot-temp-server.fls.red
docker compose -f ./docker-compose-initiate.yml down
 
# some configurations for let's encrypt
curl -L --create-dirs -o etc/letsencrypt/options-ssl-nginx.conf https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf
openssl dhparam -out etc/letsencrypt/ssl-dhparams.pem 2048
 
# Phase 2
crontab ./etc/crontab
docker compose -f ./docker-compose.yml up -d
