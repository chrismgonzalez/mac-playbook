#!/bin/sh

NODE_VERSION=""

echo "-------------------------------"
echo "Installing nvm"
echo "-------------------------------"

# check if nvm is installed
if [ ! -d "${HOME}/.nvm/.git" ]; then
    echo 'nvm is not installed, installing'
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    if [ -s $HOME/.nvm/nvm.sh ]; then 
      . $HOME/.nvm/nvm.sh >> $HOME/.zshrc
      source $HOME/.zshrc
    fi
  else
    echo 'nvm is installed, sourcing .zshrc to be on the safe side'
    source $HOME/.zshrc
fi

if ! [ -x "$(command -v node)" ]; then
  echo 'Node & npm is not installed, installing' >&2
  nvm install ${NODE_VERSION}
  nvm use ${NODE_VERSION}
  npm -v
  node -v
fi