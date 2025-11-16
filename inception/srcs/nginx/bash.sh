#!/bin/bash

mkdir -p /etc/nginx/ssl

#pour chiffrer les requêtes au serveur 
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=State/L=City/O=Organization/CN=localhost"

chmod 600 /etc/nginx/ssl/inception.key

nginx -g "daemon off;"
