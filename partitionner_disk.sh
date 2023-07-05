#!/bin/bash

# Afficher les disques
lsblk

# Demander l'entrée de l'utilisateur pour le chemin complet du disque à partitionner
read -p "Veuillez entrer le chemin complet du disque à partitionner (ex: /dev/sdb) : " diskpath

# Vérifier si le disque existe
if [ ! -e "$diskpath" ]; then
  echo "Le disque $diskpath n'existe pas. Veuillez vérifier le chemin et réessayer."
  exit 1
fi

# Utiliser fdisk pour partitionner le disque
sudo fdisk "$diskpath" <<EOF
n
p
1

+4G
n
p
2

+4G
n
p
3


w
EOF

# Afficher les informations sur les partitions
sudo fdisk -l "$diskpath"