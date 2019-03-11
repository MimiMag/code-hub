
#!/usr/bin/env bash

# Styling
TITLE="\033[1;37m\033[40m"
NORMAL="\033[0;39m"
BOLD_RED="\033[0;1;31m"
GREEN="\033[32m"

function title {
  echo
  echo " $TITLE$1$NORMAL"
}

function success {
  echo "$GREEN$1"
}

function error {
  echo "$BOLD_RED$1"
}

title "Check for necessary commands"

if which git  &> /dev/null
then
  success "  ✔ Git is installed: OK!"
else
  error "Git is not installed! Install it (e.g. brew install git)"
fi


if [ $(which nvm | grep "not found") ]
then
  error "NVM is not installed. Installing..."
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh
  error "Close your terminal and open a new session to load NVM. Then run this script again."
  exit 1
else
    success "  ✔ NVM installed: OK!"
fi

title "Check global dependencies"
title "Check for right node environment"
title "Pull latest version (of master)"
title "Install local dependencies"
title "Further Instructions"
