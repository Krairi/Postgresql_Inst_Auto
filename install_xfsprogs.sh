#!/bin/bash

# Vérifier si l'utilisateur courant a les privilèges d'administration
if [[ $(id -u) -ne 0 ]]; then
  echo "Vous devez exécuter ce script en tant qu'administrateur."
  exit 1
fi

# Mettre à jour le système
apt update
apt upgrade

# Installer xfs
apt install xfsprogs

# Afficher un message de fin
echo "L'installation de xfsprogs est terminée."
