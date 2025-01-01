#!/bin/bash

# update packages
sudo apt update
sudo apt install -y curl
# install bash libs
chmod +x /home/user/devenv/bash/install.sh
/home/user/devenv/bash/install.sh
# install vim libs
chmod +x /home/user/devenv/vim/install.sh
/home/user/devenv/vim/install.sh
# Copy .bashrc
cp /home/user/devenv/dotfiles/.bashrc /home/user/.bashrc
# Copy .vimrc
cp /home/user/devenv/dotfiles/.vimrc /home/user/.vimrc
