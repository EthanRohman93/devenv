#!/bin/bash

# Update packages
sudo apt update
sudo apt install -y curl
local SUDO_USER_NAME=$(whoami)
# Identify the current sudo user's home directory
# Install bash libs
chmod +x "/home/${SUDO_USER_NAME}/devenv/bash/install.sh"
/home/${SUDO_USER_NAME}/devenv/bash/install.sh
# Install vim libs
chmod +x "/home/${SUDO_USER_NAME}/devenv/vim/install.sh"
/home/${SUDO_USER_NAME}/devenv/vim/install.sh
# Copy .bashrc
cp "/home/${SUDO_USER_NAME}/devenv/dotfiles/.bashrc" "/home/${SUDO_USER_NAME}/.bashrc"
source "/home/${SUDO_USER_NAME}/.bashrc"
# Copy .vimrc
cp "/home/${SUDO_USER_NAME}/devenv/dotfiles/.vimrc" "/home/${SUDO_USER_NAME}/.vimrc"
