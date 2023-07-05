#!/bin/bash

# Vérifier si l'utilisateur courant a les privilèges d'administration
if [[ $(id -u) -ne 0 ]]; then
  echo "Vous devez exécuter ce script en tant qu'administrateur."
  exit 1
fi

# Définir les variables pour le nom du VG, du LV de données et du LV de logs
VG_NAME="movievg"
DATA_LV_NAME="data"
LOG_LV_NAME="logs"

# Calculer la taille en PE (physical extent) pour les LV de données et de logs
# DATA_SIZE_PE=$(expr 10 \* 1024 \* 1024 \/ 512) # 10 Go en PE (taille ajustable)
# LOG_SIZE_PE=$(expr 2 \* 1024 \* 1024 \/ 512) # 2 Go en PE (taille ajustable)

# Créer le LV de données
lvcreate -n $DATA_LV_NAME -L 10G /dev/$VG_NAME

# Formater le LV de données en xfs
mkfs.xfs /dev/$VG_NAME/$DATA_LV_NAME

# Créer le point de montage pour le LV de données
mkdir /var/lib/postgresql/

# Ajouter l'entrée dans /etc/fstab (data) 
echo "/dev/$VG_NAME/$DATA_LV_NAME /var/lib/postgresql/ xfs defaults 0 0" >> /etc/fstab

# Créer le LV de logs
lvcreate -n $LOG_LV_NAME -l 510 /dev/$VG_NAME

# Formater le LV de logs en xfs
mkfs.xfs /dev/$VG_NAME/$LOG_LV_NAME

# Créer le point de montage pour le LV de logs
mkdir /var/log/postgresql/

# Ajouter l'entrée dans /etc/fstab (logs)
echo "/dev/$VG_NAME/$LOG_LV_NAME /var/log/postgresql/ xfs defaults 0 0" >> /etc/fstab

# Monter tous les systèmes de fichiers spécifiés dans le fichier /etc/fstab sur le système
mount -a

# Afficher nos points de montage
lsblk -f

# Afficher un message volume logique
echo "Les volumes logiques pour les données et les journaux ont été créés avec succès. (Effectuer un sudo reboot)"

