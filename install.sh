#!/bin/bash

# update packages
sudo apt update
sudo apt install -y curl
# install bash libs
chmod +x /home/test_beast/devenv/bash/install.sh
/home/test_beast/devenv/bash/install.sh
# install vim libs
chmod +x /home/test_beast/devenv/vim/install.sh
/home/test_beast/devenv/vim/install.sh
# Copy .bashrc
cp /home/test_beast/devenv/dotfiles/.bashrc /home/test_beast/.bashrc
# Copy .vimrc
cp /home/test_beast/devenv/dotfiles/.vimrc /home/test_beast/.vimrc
