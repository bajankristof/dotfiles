#!/bin/bash

set -e

cd "${0:a:h}"

source ../colors.zsh
source packages.zsh

if ! command -v yay &> /dev/null; then
  blue 'Installing Yay...'
  mkdir -p ~/.local/share
  git clone https://aur.archlinux.org/yay-bin.git ~/.local/share/yay-bin
  pushd ~/.local/share/yay-bin
  makepkg -si --noconfirm
  popd
  rm -rf ~/.local/share/yay-bin
  green 'done'
fi

blue 'Installing packages...'
sudo pacman -Syu --needed --noconfirm "${PACKAGES[@]}"
green 'done'
echo ''

blue 'Installing AUR packages...'
yay -Syu --needed --noconfirm "${AUR_PACKAGES[@]}"
green 'done'
echo ''

blue 'Changing shell...'
chsh -s /usr/bin/zsh
sudo chsh -s /usr/bin/zsh
green 'done'
echo ''

zsh ../stow.zsh
zsh ../common/install.zsh

blue 'Configuring services...'
sudo systemctl enable bluetooth
sudo systemctl enable NetworkManager
green 'done'
echo ''

