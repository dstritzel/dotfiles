#!/usr/bin/env bash

# Config Section
COPY_ALWAYS="ssh"
EXCLUDES="install.sh"
TAGS=""

if [ -n "$WSL_DISTRO_NAME" ]; then
  echo "Running in WSL: $WSL_DISTRO_NAME"
  TAGS="$TAGS wsl"
else
  echo "Not running WSL"
fi

if [ -z "$USER" ]; then
  USER=$(id -un)
fi

mv /workspaces/.codespaces/.persistedshare/dotfiles "$HOME/dotfiles"

cd "$HOME" || return

export SUDO_ASKPASS=/bin/true

# Install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

sudo apt-get install -y silversearcher-ag

sudo apt-get update
sudo apt-get install -y rcm fzf

yes | rcup -d dotfiles

# dotfiles wanted
# .zshrc
# .zprofile
