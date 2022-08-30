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
echo "${BASE_FOLDER}/secrets created - you should run the following command after finsihing your setup to secure your secrets:"
echo ">  sudo chown root:root ${BASE_FOLDER}/secrets && sudo chmod 600  ${BASE_FOLDER}/secrets "

echo "Setting rights to ${USER}:${GROUP} again for all files/folders..."
chown -R ${USER}:${GROUP} ${BASE_FOLDER} || error "Failed to CHOWN"
# chmod -R 775 ${BASE_FOLDER} || error "Failed to CHMOD"
# better way with different rights for folders and existing files (if they exist)
sudo find ${BASE_FOLDER} -type d -exec chmod 775 {} + || error "Failed to CHMOD for Directories"
sudo find ${BASE_FOLDER} -type f -exec chmod 664 {} + || error "Failed to CHMOD for Files"

echo "Setup complete."
