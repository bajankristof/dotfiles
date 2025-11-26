#!/bin/zsh

set -e

cd "${0:a:h}"

git submodule update --init --recursive

if [[ $OSTYPE = 'darwin'* ]]; then
  zsh setup/macos/install.zsh
else
  zsh setup/arch/install.zsh
fi
