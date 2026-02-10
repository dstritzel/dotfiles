#!/usr/bin/env bash

if [ -z "$USER" ]; then
  USER=$(id -un)
fi

if [ -f "$HOME/.rcrc" ]; then
  echo "Exiting, .rcrc file already exists"
  echo "Edit ~/.rcrc file and run rcup manually to update your dotfiles"
  echo " *** This fuctionality may change in the future ***"
  exit 1
fi

# Config Section
COPY_OVERWRITE="true"
COPY_ALWAYS="ssh/* config/*"
EXCLUDES="install.sh README.md includes/*"
TAGS="$USER $1"
CODESPACE_NAME="false"
SYMLINK_DIRS=""
UNDOTTED_DIRS=""

if [ -n "$WSL_DISTRO_NAME" ]; then
  echo "Running in WSL: $WSL_DISTRO_NAME"
  TAGS="$TAGS wsl"
else
  echo "Not running WSL"
fi
# Detect OS type
OS_TYPE=""
if [ "$(uname)" = "Darwin" ]; then
  echo "Running on macOS"
  TAGS="$TAGS mac"
  . includes/mac_functions.sh
elif [ "$(uname)" = "Linux" ]; then
  echo "Running on Linux"
  OS_TYPE="linux"
  TAGS="$TAGS linux"
  . includes/linux_functions.sh
elif [ "$(uname)" = "FreeBSD" ]; then
  echo "Running on FreeBSD"
  TAGS="$TAGS freebsd"
  . includes/freebsd_functions.sh
fi

if [ -n "$CODESPACE_NAME" ] || [ -n "$GITHUB_CODESPACE_NAME" ]; then
  echo "Script is running in GitHub Codespaces."
  mv /workspaces/.codespaces/.persistedshare/dotfiles "$HOME/.dotfiles"
  CODESPACE_NAME="true"
fi

cd "$HOME" || return

export SUDO_ASKPASS=/bin/true

# Install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

if [ "$OS_TYPE" = "ubuntu" ]; then
  sudo apt-get update
  sudo apt-get install -y rcm fzf
  sudo apt-get install -y silversearcher-ag
elif [ "$OS_TYPE" = "fedora" ]; then
  sudo dnf update
  sudo dnf install -y rcm fzf
elif [ "$OS_TYPE" = "freebsd" ]; then
  sudo pkg update
  sudo pkg install -y rcm fzf
elif [ "$OS_TYPE" = "mac" ]; then
  . includes/mac_functions
  install_brew
  brew install rcm fzf
fi

if [[ ! -f "$HOME/.antidote" ]]; then
  echo "Installing Antidote"
  git clone https://github.com/mattmc3/antidote.git ~/.antidote
  echo "source ~/.antidote/antidote.zsh" >> ~/.zshrc
  echo "antidote load" >> ~/.zshrc
fi

echo Writing rcrc file...
echo "COPY_OVERWRITE=$COPY_OVERWRITE">$HOME/.rcrc
echo "COPY_ALWAYS=$COPY_ALWAYS">>$HOME/.rcrc
echo "EXCLUDES=$EXCLUDES">>$HOME/.rcrc
echo "TAGS=$TAGS">>$HOME/.rcrc
echo "SYMLINK_DIRS=$SYMLINK_DIRS">>$HOME/.rcrc
echo "UNDOTTED_DIRS=$UNDOTTED_DIRS">>$HOME/.rcrc

if [ "$COPY_OVERWRITE" = "true" ]; then
  yes | rcup -Cf
else
  yes | rcup -fd .dotfiles
fi

# dotfiles wanted
# .zshrc
# .zprofile
