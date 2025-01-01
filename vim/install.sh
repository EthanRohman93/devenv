#!/bin/bash

# Run vim plugin install
echo "Removing existing $HOME/.vim/bundle directory..."
rm -rf $HOME/.vim/bundle
# Create necessary directories for Pathogen
echo "Creating directories for Pathogen..."
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle
# Download and install Pathogen
echo "Downloading and installing Pathogen..."
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# Clone plugins into the $HOME/.vim/bundle directory
echo "Cloning Vim plugins..."
# vim-lsp
git clone https://github.com/prabirshrestha/vim-lsp.git $HOME/.vim/bundle/vim-lsp
# vim-lsp-settings
git clone https://github.com/mattn/vim-lsp-settings.git $HOME/.vim/bundle/vim-lsp-settings
# asyncomplete
git clone https://github.com/prabirshrestha/asyncomplete.vim.git $HOME/.vim/bundle/asyncomplete.vim
# gruvbox
git clone https://github.com/morhetz/gruvbox.git $HOME/.vim/bundle/gruvbox
# rose-pine
git clone --depth=1 https://github.com/rose-pine/vim.git $HOME/.vim/bundle/rosepine
# fzf.vim
git clone https://github.com/junegunn/fzf.vim.git $HOME/.vim/bundle/fzf.vim
# Confirmation message
echo "Vim environment setup complete!"
# Run fzf install
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.vim/bundle/fzf
chmod +x ~/.vim/bundle/fzf/install
~/.vim/bundle/fzf/install
