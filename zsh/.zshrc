#!/bin/zsh

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gentoo"

plugins=(
	autojump
	colored-man-pages
	fd
	fzf
	git
	gpg-agent
	mosh
	pass
	ripgrep
)

source $ZSH/oh-my-zsh.sh

export FZF_TMUX=1
export FZF_TMUX_OPTS='-p90%,80%'
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
alias mkdir="mkdir -p"
alias sl="ls"

bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line
