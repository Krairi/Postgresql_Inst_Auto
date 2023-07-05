#!/bin/bash


POSTEGRE_HBA_CONF="/etc/postgresql/15/main/pg_hba.conf"
POSTEGRE_CONF="/etc/postgresql/15/main/postgresql.conf"

GIT_DB_DATA_LINK="https://github.com/matthcol/dbmovie"
BRANCH_GIT="pg-nodocker"
# Demander différentes information à l'utilisateur
read -p "Veuillez entrer le nom de votre home(ex: djawed) : " USER_P
read -p "Veuillez entrer le nom de la data base postgresql (ex: postgres) : " DATA_BASE
read -p "Veuillez entrer le nom du nouvel utilisateur postgresql (ex: movie) : " LOGIN_DB
read -p "Veuillez entrer le mot de passe du nouvel utilisateur postgresql (ex: password) : " PASSWORD_DB
read -p "Veuillez entrer le chemin complet de votre home (ex: /home/djawed) : " HOME_DIRECTORY_CURRENT_USER
read -p "Veuillez entrer l'adresse IP avec le mask (ex: 192.168.186.0/24) : " IP_WITH_MASQUE
read -p "Veuillez entrer votre ip ens36 (ex: 192.168.186.132) : " IP_ENS36
read -p "Veuillez entrer le nom du fichier git sql à exécuter (ex: pg_movie_all.sql) : " FICHIER_SQL


# modifier les fichier conf 

echo "host $DATA_BASE   $LOGIN_DB  $IP_WITH_MASQUE   scram-sha-256" >> $POSTEGRE_HBA_CONF
echo "listen_addresses='*'" >> $POSTEGRE_CONF

# Créer un utilisateur avec le droit LOGIN et un mot de passe

su - postgres -c "psql -c \" create user $LOGIN_DB with login password '$PASSWORD_DB'\""
su - postgres -c "psql -c \" GRANT CREATE ON SCHEMA public TO $LOGIN_DB\""

# Arrêter le service NAT
ifdown ens33

# Redémarrer le service NAT
ifup ens33

# Aller dan le home de mon utilisateur
cd $HOME_DIRECTORY_CURRENT_USER
su - $USER_P -c "git clone -b $BRANCH_GIT $GIT_DB_DATA_LINK"

cd $HOME_DIRECTORY_CURRENT_USER/dbmovie/sql
#redemarrage des fichier de config du service postgres
systemctl restart postgresql.service

PGPASSWORD=$PASSWORD_DB psql -U $LOGIN_DB -d $DATA_BASE -h $IP_ENS36 -f $FICHIER_SQL 
PGPASSWORD=$PASSWORD_DB psql -U $LOGIN_DB -d $DATA_BASE -h $IP_ENS36 -c 'select count(*) from movies;'