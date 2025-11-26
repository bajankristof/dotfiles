#!/bin/zsh

cd "${0:A:h}"

source ../colors.zsh
source ../../common/.config/zsh/asdf.zsh

blue 'Installing TypeScript language server...'
asdfl nodejs npm i -g @typescript/native-preview > /dev/null 2>&1
code=$?
if [ $code -eq 0 ]; then
  green 'done'
elif [ $code -eq 126 ]; then
  yellow 'Node.js not found in asdf, skipping TypeScript language server installation.'
fi
echo ''

blue 'Installing Ruby language server...'
asdfl ruby gem install ruby-lsp ruby-lsp-rails ruby-lsp-rspec --conservative > /dev/null 2>&1
code=$?
if [ $code -eq 0 ]; then
  green 'done'
elif [ $code -eq 126 ]; then
  yellow 'Ruby not found in asdf, skipping Ruby language server installation.'
fi
echo ''

