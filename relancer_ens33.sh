#!/bin/bash

# Vérifier si l'utilisateur a les droits d'administrateur
if [ "$(id -u)" != "0" ]; then
   echo "Ce script doit être exécuté en tant qu'administrateur" 1>&2
   exit 1
fi

# Arrêter le service NAT
ifdown ens33

# Redémarrer le service NAT
ifup ens33

# Vérifier le statut du service
ip a