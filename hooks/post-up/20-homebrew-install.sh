#!/usr/bin/env bash

if [[ ! -d /home/linuxbrew/.linuxbrew && ! -d /opt/homebrew ]] && echo "$TAGS" | grep -q -w "homebrew"; then
  echo "Installing Homebrew.. A sudo password may be required."
  echo "If you have concerns this is script $0"
  # TODO: Add check if we can skip.
  read -p "Press enter to continue"
  echo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
