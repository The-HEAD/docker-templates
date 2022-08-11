#!/bin/bash

###############
# Please setup the Environment Variables First !
##############

source .env

###############
# Setup Script for the file structure

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating base directory..."
sudo mkdir -p ${BASE_FOLDER} || error "Failed to create base docker folder!"
echo "Setting rights to ${USER}:${GROUP}..."
sudo chown -R ${USER}:${GROUP} ${BASE_FOLDER} || error "Failed to set rigths"
sudo chmod -R 755 ${BASE_FOLDER}

echo "Creating a sub-folder structure"
mkdir -p ${BASE_FOLDER}/appdata || error "Failed to create subfolder appdata folder!"
mkdir -p ${BASE_FOLDER}/custom || error "Failed to create subfolder shared folder!"
mkdir -p ${BASE_FOLDER}/logs || error "Failed to create subfolder shared folder!"
mkdir -p ${BASE_FOLDER}/shared || error "Failed to create subfolder shared folder!"
mkdir -p ${BASE_FOLDER}/secrets || error "Failed to create subfolder shared folder!"

touch ${BASE_FOLDER}/appdata/test.txt || error "Failed to create traefik route config!"

echo "Setting rights to ${USER}:${GROUP} again for all files/folders..."
chown -R ${USER}:${GROUP} ${BASE_FOLDER} || error "Failed to CHOWN"
chmod -R 755 ${BASE_FOLDER} || error "Failed to CHMOD"

echo "Setup complete."
