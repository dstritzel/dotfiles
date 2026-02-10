#!/usr/bin/env bash

ZSH_SYNTAX_HIGHLIGHTING_DIR=$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
if [[ -d $ZSH_SYNTAX_HIGHLIGHTING_DIR ]]; then
  git clone git@github.com:zsh-users/zsh-syntax-highlighting.git "${ZSH_SYNTAX_HIGHLIGHTING_DIR}"
else
  cd "${ZSH_SYNTAX_HIGHLIGHTING_DIR}" || true
  git pull
fi
