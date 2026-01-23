#!/bin/bash

# Install dependencies
sudo apt update
sudo apt install -y zsh snapd luajit ripgrep rustup fzf starship coreutils gpg gawk ffmpeg yt-dlp dirmngr tree-sitter-cli 
sudo snap install nvim --classic

# Setup asdf
wget -O "asdf.tar.gz" "https://github.com/asdf-vm/asdf/releases/download/v0.18.0/asdf-v0.18.0-linux-amd64.tar.gz" && \
  tar -xf "asdf.tar.gz" && \
  sudo mv asdf /usr/local/bin && \
  rm "asdf.tar.gz"
rm ~/.asdfrc
ln -s $PWD/asdfrc ~/.asdfrc

# Remove existing configurations
rm -rf ~/.vim ~/.vimrc ~/.zshrc ~/.config/nvim ~/.oh-my-zsh 2>/dev/null

# Create neovim directories
mkdir -p ~/.config

# Set zsh as default shell
sudo chsh -s $(which zsh) $(whoami)

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Symlink configs
# Oh My Zsh will add its own zshrc we need to remove first
rm ~/.zshrc 2>/dev/null
ln -s $PWD/ubuntu-zshrc ~/.zshrc
ln -s $PWD/nvim ~/.config/

# From here, we continue in zsh with appropriate env
zsh -i -c '
source ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf set nodejs latest
asdf reshim

npm install -g stylelint eslint eslint_d prettier @fsouza/prettierd
'
