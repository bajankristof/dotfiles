#!/bin/zsh

set -e

cd "${0:a:h}"

source colors.zsh

blue 'Installing dotfiles...'
stow -d .. -t "$HOME" .
green 'done'
echo ''

