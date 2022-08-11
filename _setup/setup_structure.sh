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
sudo chown -R ${USER}:${GROUP} ${BASE_FOLDER} || error "Failed to set user rigths"

echo "Creating a sub-folder structure"
mkdir -p ${BASE_FOLDER}/appdata || error "Failed to create subfolder appdata folder!"
mkdir -p ${BASE_FOLDER}/custom || error "Failed to create subfolder custom folder!"
mkdir -p ${BASE_FOLDER}/logs || error "Failed to create subfolder logs folder!"
mkdir -p ${BASE_FOLDER}/shared || error "Failed to create subfolder shared folder!"
mkdir -p ${BASE_FOLDER}/secrets || error "Failed to create subfolder secrets folder!"

echo "Setup complete."
