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
export WORKON_HOME=~/.local/share/pyenvs
export VIRTUALENVWRAPPER_PYTHON=python3
source virtualenvwrapper.sh

# Fuzzy find with fzf
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
