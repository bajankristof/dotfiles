export PATH="$HOME/.asdf/shims:$PATH"

function asdfl {
  local plugin=$1
  local command
  IFS=$' ' command="${*:2}"

  local versions
  IFS=$'\n' versions=($(asdf list $plugin 2>/dev/null))
  if [ $? -ne 0 ]; then
    return 126
  fi

  local version
  for version in ${versions[@]}; do
    version=$(echo $version | sed 's/[ \t*]//g')
    zsh -c "ASDF_${plugin:u}_VERSION=$version ${command}" || return $?
  done

  return 0
}

