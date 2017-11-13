#!/bin/zsh

autoload -U compinit
compinit

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

unsetopt correctall
unsetopt equals

autoload -U promptinit
promptinit

prompt gentoo

export HISTSIZE=5000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Breaks "eix ^asdf"
# setopt extendedglob

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

bindkey ' ' magic-space    # also do history expansion on space
bindkey '^R' history-incremental-search-backward

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey '^[[Z' reverse-menu-complete

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

export PATH=:$PATH:~/bin

. /etc/profile.d/autojump.sh
. /etc/profile.d/vte-2.91.sh
