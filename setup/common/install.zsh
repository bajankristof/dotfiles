#!/bin/zsh

set -e

cd "${0:a:h}"

zsh tsls.zsh
zsh rubyls.zsh
zsh roslynls.zsh

