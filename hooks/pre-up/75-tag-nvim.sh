#!/usr/bin/env bash

if [[ ! -d /home/linuxbrew/.linuxbrew && ! -d /opt/homebrew ]]; then
  echo "Homebrew is not installed. It is required for the latest neovim version."
  exit 1
else
  if [[ "$OS_TYPE" == "linux" && ! "$PATH" =~ "/home/linuxbrew/.linuxbrew/bin" ]]; then
    echo "Homebrew is not in the PATH. Adding it to the PATH."
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  elif [[ "$OS_TYPE" == "mac" && ! "$PATH" =~ "/opt/homebrew/bin" ]]; then
    echo "Homebrew is not in the PATH. Adding it to the PATH."
    export PATH="/opt/homebrew/bin:$PATH"
  fi
fi

if ! brew list "neovim"; then
  echo "neovim is not installed. Installing..."
  brew install neovim
  #TODO: add check if we need to update neovim.
fi

if [[ ! -d "${HOME}/config/nvim" ]]; then
  echo "nvim LazyVim not cloned. Cloning..."
  git clone https://github.com/LazyVim/starter.git "${HOME}/config/nvim"
else
  echo "nvim LazyVim already cloned. Updating..."
  git -C "${HOME}/config/nvim" pull
fi