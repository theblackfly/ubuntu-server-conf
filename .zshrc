# Blackfly's ZSH config

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd  # automatically cd into typed directory
stty stop undef  # disable ctrl-s to freeze terminal
setopt interactive_comments

# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.cache/zsh/history

# Use modern completion system
# autoload -Uz compinit
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)  # include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

set -o vi

# Keep $HOME clean
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME:/.config}/jupyter"

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# PATH
export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

# Virtualenvwrapper
export WORKON_HOME="$XDG_DATA_HOME/pyenvs"
export VIRTUALENVWRAPPER_PYTHON=python3
source virtualenvwrapper.sh

# fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# Fuzzy history search with fzf
# https://github.com/joshskidmore/zsh-fzf-history-search/blob/master/zsh-fzf-history-search.zsh
fzf_history_search() {
  setopt extendedglob
  candidates=(${(f)"$(fc -li -1 0 | fzf +s +m -x -e -q "$BUFFER")"})
  local ret=$?
  if [ -n "$candidates" ]; then
    BUFFER="${candidates[@]/(#m)*/${${(As: :)MATCH}[4,-1]}}"
    BUFFER="${BUFFER[@]/(#b)(?)\\n/$match[1]
}"
    zle vi-fetch-history -n $BUFFER
  fi
  zle reset-prompt
  return $ret
}

autoload fzf_history_search
zle -N fzf_history_search

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey '^r' fzf_history_search
