#!/bin/bash

# Install dependencies
brew install zsh tmux neovim python3 ag reattach-to-user-namespace antigen
brew tap homebrew/cask-cask

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install neovim
pip3 install powerline-status

# Install font
brew tap homebrew/cask-fonts
brew cask install font-firacode-nerd-font

# Set zsh as default shell
chsh -s /usr/local/bin/zsh

# Remove existing configurations
rm -rf ~/.vim ~/.vimrc ~/.zshrc ~/.tmux ~/.tmux.conf ~/.config/nvim 2> /dev/null

# Create neovim directories
mkdir -p ~/.config ~/.config/nvim

# Symlink configs
ln -s $PWD/zshrc ~/.zshrc
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/vimrc ~/.config/nvim/init.vim

# Use nvim for further configuration
alias vim="nvim"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
