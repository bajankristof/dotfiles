#!/bin/zsh

set -e

cd "${0:a:h}"

source ../colors.zsh

blue 'Installing Roslyn language server...'

OS='linux'
if [[ $OSTYPE == 'darwin'* ]]; then
  OS='osx'
fi

PLATFORM="${OS}-x64"
case "$(uname -m)" in
  'aarch64' | 'arm64') PLATFORM="${OS}-arm64" ;;
esac

BASE_URL='https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/flat2'
PACKAGE="microsoft.codeanalysis.languageserver.${PLATFORM}"
VERSION="$(curl -sSL "${BASE_URL}/${PACKAGE}/index.json" | jq -r '.versions[0]')"

mkdir -p ~/.local/share/roslynls
mkdir -p ~/.local/state/roslynls/logs
mkdir -p ~/.cache/roslynls
trap 'rm -rf ~/.cache/roslynls' EXIT

(
  cd ~/.cache/roslynls
  if command -v wget &> /dev/null; then
    wget -q --show-progress -O roslynls.nupkg "${BASE_URL}/${PACKAGE}/${VERSION}/${PACKAGE}.${VERSION}.nupkg"
  else
    curl -fL "${BASE_URL}/${PACKAGE}/${VERSION}/${PACKAGE}.${VERSION}.nupkg" -o roslynls.nupkg
  fi

  unzip -q -o roslynls.nupkg "content/LanguageServer/${PLATFORM}/*"
  rm -rf ~/.local/share/roslynls/*(N)
  mv "content/LanguageServer/${PLATFORM}/"* ~/.local/share/roslynls/
)

green 'done'
echo ''

