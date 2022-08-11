#!/bin/bash

source .env

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}


######################
## create folders
echo "Setup Folder Structure for Traefik"
mkdir -p ${BASE_FOLDER}/appdata/traefik/acme || error "Failed to create traefik/acme folder!"
mkdir -p ${BASE_FOLDER}/appdata/traefik/log || error "Failed to create traefik/log folder!"
mkdir -p ${BASE_FOLDER}/appdata/traefik/config || error "Failed to create traefik/config folder!"

######################
## touch files
echo "Creating empty files"
touch ${BASE_FOLDER}/appdata/traefik/acme/acme.json || error "Failed to create acme.json!"
touch ${BASE_FOLDER}/appdata/traefik/log/access.log || error "Failed to create access.log!"
touch ${BASE_FOLDER}/appdata/traefik/log/traefik.log || error "Failed to create traefik.log!"

######################
## download predefined files / overwrites all files!
echo "Downloading base configuration (overwriting existing files)"
wget -qN ${GITHUB_URL_RAW}/appdata/traefik/traefik.yml -P ${BASE_FOLDER}/appdata/traefik
wget -qN ${GITHUB_URL_RAW}/appdata/traefik/config/tls.yml -P ${BASE_FOLDER}/appdata/traefik/config
wget -qN ${GITHUB_URL_RAW}/appdata/traefik/config/middlewares.yml -P ${BASE_FOLDER}/appdata/traefik/config
wget -qN ${GITHUB_URL_RAW}/appdata/traefik/config/middlewares-chains.yml -P ${BASE_FOLDER}/appdata/traefik/config
wget -qN ${GITHUB_URL_RAW}/appdata/traefik/config/app-apache.yml -P ${BASE_FOLDER}/appdata/traefik/config
wget -qN ${GITHUB_URL_RAW}/appdata/traefik/config/app-ispconfig.yml -P ${BASE_FOLDER}/appdata/traefik/config

######################
## set correct rights for acme.json
echo "Setting right 600 to acme.json"
chmod -R 600 ${BASE_FOLDER}/appdata/traefik/acme/acme.json

######################
## Creating Basic Authentication User
echo "Creating User for Basic Authentication"
mkdir -p ${BASE_FOLDER}/shared || error "Failed to create subfolder shared folder!"
htpasswd -b -c ${BASE_FOLDER}/shared/.htpasswd ${AUTH_USER} ${AUTH_PASSWORD}

