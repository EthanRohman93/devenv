#!/bin/bash

# update packages
sudo apt update
sudo apt install -y curl
# make devenv directory
mkdir $HOME/.devenv
# install bash libs
bash/install.sh
# install vim libs
vim/install.sh
# Copy .bashrc
cp dotfiles/.bashrc $HOME/.bashrc
# Copy .vimrc
cp dotfiles/.vimrc $HOME/.vimrc
