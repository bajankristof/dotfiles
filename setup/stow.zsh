#!/bin/zsh

set -e

cd "${0:a:h}"

source colors.zsh

blue 'Installing dotfiles...'
stow -d .. -t "$HOME" common
if [[ $OSTYPE = 'darwin'* ]]; then
  stow -d .. -t "$HOME" macos
else
  stow -d .. -t "$HOME" arch
fi
green 'done'
echo ''

