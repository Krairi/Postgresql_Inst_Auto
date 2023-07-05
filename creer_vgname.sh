#!/bin/bash

# Afficher les disques
lsblk

# Demander l'entrée de l'utilisateur pour le nom du VG et le chemin du périphérique
read -p "Veuillez entrer un nom pour le nouveau VG (ex: movievg) : " vgname
read -p "Veuillez entrer le chemin complet du 1er périphérique à utiliser (ex: /dev/sdc) : " devicepathp
read -p "Veuillez entrer le chemin complet du 2nd périphérique à utiliser (ex: /dev/sdb1) : " devicepaths

# Vérifier si le 1er périphérique existe
if [ ! -e "$devicepathp" ]; then
  echo "Le périphérique $devicepathp n'existe pas. Veuillez vérifier le chemin et réessayer."
  exit 1
fi

# Vérifier si le 2nd périphérique existe
if [ ! -e "$devicepaths" ]; then
  echo "Le périphérique $devicepaths n'existe pas. Veuillez vérifier le chemin et réessayer."
  exit 1
fi

# Demander l'entrée de l'utilisateur pour le répertoire dans lequel créer le VG
read -p "Veuillez entrer le chemin complet du répertoire dans lequel vous souhaitez créer le VG (par défaut: /dev) : " vgpath

# Utiliser le répertoire /dev par défaut si aucun chemin n'a été fourni
if [ -z "$vgpath" ]; then
  vgpath="/dev"
fi

# Vérifier si le répertoire existe
if [ ! -d "$vgpath" ]; then
  echo "Le répertoire $vgpath n'existe pas. Veuillez vérifier le chemin et réessayer."
  exit 1
fi

# Créer le nouveau VG
sudo vgcreate "$vgname" "$devicepathp" "$devicepaths"

# Afficher les informations du nouveau VG
sudo vgdisplay "$vgname"