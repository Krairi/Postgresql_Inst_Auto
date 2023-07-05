#!/bin/bash

# Vérifier si l'utilisateur courant a les privilèges d'administration
if [[ $(id -u) -ne 0 ]]; then
  echo "Vous devez exécuter ce script en tant qu'administrateur."
  exit 1
fi

# Installation des dépendances
apt-get update
apt-get install wget sudo curl gnupg2 -y
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Téléchargement de la clé de signature de PostgreSQL
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Mise à jour de la liste des paquets disponibles
apt -y update

# Installation de PostgreSQL 15 et de l'outil en ligne de commande psql
apt-get install postgresql-15 -y

# Démarrage du service PostgreSQL
systemctl start postgresql

# Activation du démarrage automatique du service PostgreSQL
systemctl enable postgresql

# Verifier si le service est actif
systemctl status postgresql

# Verifier si postgresql est bien reconnu
netstat -tuplan | grep -i listen
