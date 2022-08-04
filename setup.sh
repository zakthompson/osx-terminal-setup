#!/bin/bash

# Install dependencies
brew install zsh tmux neovim ag yarn tree-sitter luajit ripgrep rustup
brew tap homebrew/cask-cask

# Inctall rust/cargo
rustup-init -y

# Neovim setup
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# tmux setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install font
brew tap homebrew/cask-fonts
brew cask install font-jetbrains-mono-nerd-font

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
ln -s $PWD/nvim ~/.config/nvim

# Use nvim for further configuration
alias vim="nvim"
