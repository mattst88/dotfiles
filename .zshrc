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
setopt share_history

# Breaks "eix ^asdf"
# setopt extendedglob

bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line
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

alias pkgdiff="pkgdiff-mg"
alias grpe="grep"
alias gti="git"
alias sl="ls"

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)

FILES=(
	/etc/profile.d/autojump.sh
	/etc/profile.d/vte-2.91.sh
	/usr/share/fzf/key-bindings.zsh
)

for file in "${FILES[@]}"; do
	[[ -e $file ]] && . "${file}"
done
