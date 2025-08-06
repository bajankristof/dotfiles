# zmodload zsh/zprof

export LANG='en_US.UTF-8'
export CLICOLOR='auto'
export HISTSIZE='10000'
export SAVEHIST='10000'

autoload -Uz compinit && compinit

setopt APPEND_HISTORY
setopt AUTO_CD
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt NO_BEEP
setopt RM_STAR_WAIT
setopt SHARE_HISTORY

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' special-dirs true

source $HOME/.config/zsh/brew.zsh
for entry in $HOME/.config/zsh/^brew.zsh; do
  if [[ -d $entry ]]; then
    local file="$entry/$(basename $entry).zsh"
    if [[ -f $file ]]; then
      source $file
    fi
  elif [[ $entry == *.zsh ]]; then
    source $entry
  fi
done

bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^f' autosuggest-accept
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode

eval "$(starship init zsh)"

# zprof

