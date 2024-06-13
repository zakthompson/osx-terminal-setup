#!/bin/bash

# Install dependencies
brew install zsh neovim ag yarn tree-sitter luajit ripgrep rustup fzf typewritten
yarn global add stylelint eslint eslint_d prettier @fsouza/prettierd
rustup-init -y

# Neovim setup
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install font
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# Set zsh as default shell
chsh -s /usr/local/bin/zsh

# Remove existing configurations
rm -rf ~/.vim ~/.vimrc ~/.zshrc ~/.config/nvim ~/.config/kitty 2>/dev/null

# Create neovim directories
mkdir -p ~/.config ~/.config/nvim ~/.config/kitty

# Install Oh My Zsh and themes/plugins
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Hush login message
touch ~/.hushlogin

# Symlink configs
ln -s $PWD/zshrc ~/.zshrc
ln -s $PWD/nvim ~/.config/nvim
ln -s $PWD/kitty ~/.config/kitty

# Use nvim for further configuration
alias vim="nvim"
