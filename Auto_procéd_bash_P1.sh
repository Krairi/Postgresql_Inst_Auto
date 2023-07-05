#!/bin/bash

# Relancer mon serveur
sudo sh relancer_ens33.sh

# Partitionner le disk en 3 parties
sudo sh partitionner_disk.sh

# Creer un nouveau vgname
sudo sh creer_vgname.sh

# Relancer mon serveur
sudo sh relancer_ens33.sh

# Installer xfs
sudo sh install_xfsprogs.sh

# Relancer mon serveur
sudo sh relancer_ens33.sh

# Monter le LV de data et logs postgresql
sudo sh lvcreate_log_data.sh

# Relancer mon serveur
sudo sh relancer_ens33.sh

# Installer postgresql
sudo sh install_postgresql_15.sh

# Relancer mon serveur
sudo sh relancer_ens33.sh

# Créer un nouvel utilisateur postgresql
sudo sh creer_nouvel_user_postgres.sh

# Terminer le script
exit 0