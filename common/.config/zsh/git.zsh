function gmb {
  git rev-parse --git-dir &>/dev/null || return

  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done

  echo master
  return 1
}

function gff {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

alias g='git'
alias ga='git add'
alias gaa='git add .'
alias gai='git add -i'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbm='git branch -m'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gc='git commit'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout $(gmb)'
alias gcl='git clone --recurse-submodules'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gl='git pull'
alias glg='git log --stat'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpt='git push --tags'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase $(gmb)'
alias grbo='git rebase --onto'
alias grh='git reset'
alias grhh='git reset --hard'
alias grhs='git reset --soft'
alias grs='git restore'
alias grst='git restore --staged'
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'
alias grm='git rm'
alias grmc='git rm --cached'
alias gsh='git show'
alias gst='git status'
alias gsta='git stash'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gsti='git stash -p'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsua='git submodule add'
alias gsus='git submodule sync --recursive'
alias gsuu='git submodule update --init --recursive'
alias gt='git tag'
