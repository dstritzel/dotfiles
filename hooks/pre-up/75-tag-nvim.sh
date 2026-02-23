#!/usr/bin/env bash

#TODO: See if we can make this look cleaner.
if ! grep -q -w "nvim" <<< "$TAGS"; then
  echo "nvim tag not found: skipped."
  exit 0
fi

if [[ -d "${HOME}/config/nvim" ]]; then
  echo "nvim LazyVim already cloned"
  # TODO: Work on more checks and do a git update
else
  git clone https://github.com/LazyVim/starter.git "${HOME}/config/nvim"
fi
