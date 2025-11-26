#!/bin/zsh

set -e

cd "${0:a:h}"

source ../colors.sh

if ! command -v brew &> /dev/null; then
  blue 'Installing Homebrew...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  green 'done'
  echo ''
fi

blue 'Installing Homebrew formulae...'
brew bundle
green 'done'
echo ''

zsh ../stow.zsh
zsh ../common/install.zsh
