#!/bin/bash

# Install dependencies
brew install zsh tmux neovim python3 ag yarn tree-sitter luajit ripgrep
brew tap homebrew/cask-cask

# Neovim setup
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install neovim
pip3 install powerline-status
yarn global add typescript typescript-language-server

# tmux setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install font
brew tap homebrew/cask-fonts
brew cask install font-firacode-nerd-font

# Set zsh as default shell
chsh -s /usr/local/bin/zsh

# Remove existing configurations
rm -rf ~/.vim ~/.vimrc ~/.zshrc ~/.tmux ~/.tmux.conf ~/.config/nvim 2> /dev/null

# Create neovim directories
mkdir -p ~/.config ~/.config/nvim

# Install Oh My Zsh and themes/plugins
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
ln -s "$ZSH_CUSTOM/themes/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM/themes/typewritten.zsh-theme"
ln -s "$ZSH_CUSTOM/themes/typewritten/async.zsh" "$ZSH_CUSTOM/themes/async"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Symlink configs
ln -s $PWD/zshrc ~/.zshrc
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/vimrc ~/.config/nvim/init.vim

# Use nvim for further configuration
alias vim="nvim"
