#!/bin/bash

# Foreground pour exec les cmd 
mysqld_safe --datadir=/var/lib/mysql &

echo "Attente du démarrage de MariaDB..."
while ! mysqladmin ping --silent; do
    sleep 1
done
echo "MariaDB est prêt!"

if mysql -e "SELECT 1;" 2>/dev/null; then
    echo "Premier démarrage - Configuration de la base de données..."
    
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -u root -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -u root -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'localhost';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';"

    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
    mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
    
    echo "Configuration terminée!"
    
    # Arrêter le Foreground 
    mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
else
    echo "Base de données déjà configurée - redémarrage..."
    mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown 2>/dev/null || mysqladmin shutdown
fi

# on lance en Background
exec mysqld_safe --datadir=/var/lib/mysql








