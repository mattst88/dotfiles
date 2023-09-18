#!/bin/zsh

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gentoo"

plugins=(
	autojump
	colored-man-pages
	fzf
	git
	mosh
	pass
	ripgrep
)

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export HISTSIZE=5000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history

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
