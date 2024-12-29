#!/bin/bash

# update packages
sudo apt update
sudo apt install -y curl
# install node/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
wait
nvm install node
# install pyenv
curl https://pyenv.run | bash
wait
pyenv update
pyenv install 3.12.5
# create pyenv venv
wait
pyenv virtualenv 3.12.5 openai_env
pyenv activate openai_env
# install requirements
pip install -r ai/requirements.txt
# deactivate venv
pyenv deactivate
cp .bashrc $HOME/.bashrc
# Copy .vimrc
cp .vimrc $HOME/.vimrc
