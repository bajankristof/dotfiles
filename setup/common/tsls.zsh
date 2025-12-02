#!/bin/zsh

cd "${0:a:h}"

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

