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

blue 'Installing Unity analyzers...'

UNITY_ANALYZERS_PACKAGE='microsoft.unity.analyzers'
UNITY_ANALYZERS_VERSION="$(curl -sSL "https://api.nuget.org/v3-flatcontainer/${UNITY_ANALYZERS_PACKAGE}/index.json" | jq -r '.versions[-1]')"

(
  cd ~/.cache/roslynls
  if command -v wget &> /dev/null; then
    wget -q --show-progress -O unity-analyzers.nupkg "https://api.nuget.org/v3-flatcontainer/${UNITY_ANALYZERS_PACKAGE}/${UNITY_ANALYZERS_VERSION}/${UNITY_ANALYZERS_PACKAGE}.${UNITY_ANALYZERS_VERSION}.nupkg"
  else
    curl -fL "https://api.nuget.org/v3-flatcontainer/${UNITY_ANALYZERS_PACKAGE}/${UNITY_ANALYZERS_VERSION}/${UNITY_ANALYZERS_PACKAGE}.${UNITY_ANALYZERS_VERSION}.nupkg" -o unity-analyzers.nupkg
  fi

  unzip -q -o unity-analyzers.nupkg "analyzers/*"
  mkdir -p ~/.local/share/roslynls/analyzers
  mv analyzers/dotnet/cs/* ~/.local/share/roslynls/analyzers/
)

green 'done'
echo ''
