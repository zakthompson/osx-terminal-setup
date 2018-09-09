#!/bin/bash

# Install dependencies
brew install zsh tmux neovim/neovim/neovim python3 ag reattach-to-user-namespace
brew tap caskroom/cask
brew cask install iterm2

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install neovim

# Install font
brew tap caskroom/fonts
brew cask install font-fira-code

# Set zsh as default shell
chsh -s /usr/local/bin/zsh

# Remove existing configurations
rm -rf ~/.vim ~/.vimrc ~/.zshrc ~/.tmux ~/.tmux.conf ~/.config/nvim 2> /dev/null

# Create neovim directories
mkdir -p ~/.config ~/.config/nvim

# Symlink configs
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim

# Use nvim for further configuration
alias vim="nvim"

