HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^p" up-line-or-beginning-search
bindkey "^n" down-line-or-beginning-search

source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -U run-help
autoload run-help-git
unalias run-help
alias help=run-help

local user_host='%{$terminfo[bold]$fg[magenta]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[green]%} %~%{$reset_color%}'

autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst

PROMPT="╭─${user_host} ${current_dir}
╰─%B$%b "

RPROMPT='[%{$fg_no_bold[yellow]%}%?%{$reset_color%}] %T %w ${vcs_info_msg_0_}'

if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  PS1='$ '
fi


zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'
zstyle ':completion:*' menu select

zstyle ':completion:*' verbose yes

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history

setopt extended_history
setopt autocd
setopt correct
setopt share_history

autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey "^X^Z" predict-on # C-x C-z
bindkey "^Z" predict-off # C-z

autoload -U colors && colors

autoload -U compinit && compinit

setopt menucomplete
zstyle ':completion:*' menu select _complete _ignored _approximate


setopt prompt_subst

zstyle ':completion:*:options' description 'yes'

export VISUAL="emacs -nw"
export EDITOR="emacs -nw"


man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}


if [ -f /usr/bin/grc ]; then
 alias gcc="grc --colour=auto gcc"
 alias log="grc --colour=auto log"
 alias netstat="grc --colour=auto netstat"
 alias ping="grc --colour=auto ping"
 alias traceroute="grc --colour=auto traceroute"
 alias diff="grc --colour=auto diff"
 alias netstat="grc --colour=auto netstat"
 alias dig="grc --colour=auto dig"
 alias make="grc --colour=auto make"
 alias gcc="grc --colour=auto gcc"
 alias g++="grc --colour=auto g++"
 alias head="grc --colour=auto head"
 alias mount="grc --colour=auto mount"
 alias ps="grc --colour=auto ps"
fi

source $HOME/.zsh/aliases
source $HOME/.zsh/path

