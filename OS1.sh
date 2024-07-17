#!/bin/bash

# Chemin vers le fichier de configuration d'Apache
APACHE_CONFIG="/etc/apache2/apache2.conf"

# Ajouter l'en-tête X-Frame-Options pour éviter les attaques de clickjacking
echo "Header always append X-Frame-Options SAMEORIGIN" >> $APACHE_CONFIG

# Ajouter l'en-tête X-Content-Type-Options pour éviter les attaques de type sniffing
echo "Header set X-Content-Type-Options nosniff" >> $APACHE_CONFIG

# Vérifier si mod_headers est activé, sinon l'activer
if ! apache2ctl -M | grep -q headers_module; then
    a2enmod headers
fi

# Redémarrer le service Apache pour appliquer les modifications
systemctl restart apache2

echo "Les en-têtes de sécurité ont été ajoutés et le service Apache a été redémarré."
