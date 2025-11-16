#!/bin/bash

sleep 10

cd /var/www/html

if [ ! -f wp-config.php ]; then
    echo "Configuration de html..."
    
    # Création du fichier de configuration html
    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/html'
    
    # Installation de html (configuration du site)
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --path='/var/www/html'
    
    # Création d'un deuxième utilisateur
    wp user create --allow-root \
        $WP_USER \
        $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=author \
        --path='/var/www/html'
    
    echo "html configuré avec succès!"
else
    echo "html déjà configuré, démarrage..."
fi

if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi

exec /usr/sbin/php-fpm8.2 -F



