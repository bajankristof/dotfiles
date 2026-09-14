#!/bin/zsh

set -e

cd "${0:a:h}"

source colors.zsh

blue 'Installing dotfiles...'
stow --restow --no-folding -d .. -t "$HOME" common
if [[ $OSTYPE = 'darwin'* ]]; then
  stow --restow --no-folding -d .. -t "$HOME" macos
else
  stow --restow --no-folding -d .. -t "$HOME" arch
fi
green 'done'
echo ''

