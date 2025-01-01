# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
make_prompt(){
	PS1='${debian_chroot:+($debian_chroot)}'

	if [ -n "$VIRTUAL_ENV" ]; then
                PS1+="$(basename $VIRTUAL_ENV)~"  # Add venv name in parentheses
        fi

	PS1+='\[\e[0;36m\]\u'
	PS1+='\[\e[0;0m\]\[\e[0;33m\]\D{%H:%M}'
	PS1+='\[\e[0;35m\]\W'

	# End Prompt Formatting
	PS1+='\[\033[00m\]:'
}

PROMPT_COMMAND='make_prompt'

#<------------[  Function Definitions  ]------------>#

# Get user "tag"- needs modularity
usertag(){
	full_user=`uname -n`
	echo ${full_user} | cut -d "-" -f 2
}

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# Function to get the current Git branch

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

complete -C /usr/bin/terraform terraform
. /usr/local/bin/z

# Set default editor to vim
export EDITOR='vim'
# pyenv setup
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# Ensure the virtualenv plugin is initialized
eval "$(pyenv virtualenv-init -)"
# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Set up fzf shell integration
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


###############################################################################

# Alias #
alias cat='batcat'
# git
alias gs='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpu='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gf='git fetch'
alias gpl='git pull'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias ga='git add'
alias gaa='git add .'
alias grm='git rm'
alias gst='git stash'
alias gsta='git stash apply'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias t='tree -I "node_modules|.git|dist|.cache"'
alias ta='tree -I "node_modules|.git|dist|.cache" -a'
alias h1='history 10'
alias totalusage='df -hl --total | grep total'
alias home='cd ~'
alias v='vim'
alias :wq='clear'
alias deere='su - deere'
alias p='pwd'
alias repo='cd /mnt/c/repos/'
alias time='vim ~/.time.md'
alias todo='vim ~/.TODO.md'
###############################################################################
# functions
tv() {
  if ! test -f "$1"; then
    touch "$1" && vim "$1"
  else
    vim "$1"
  fi
}
# Make a directory and cd into it
mcd() {
  mkdir -p "$1" && cd "$1"
}

# Go up N directories
up() {
  local count="$1"
  for ((i = 0; i < count; i++)); do
    cd ..
  done
}

# find file and open in vim
fv() {
  fzf --preview 'batcat --color=always {}' \
      --preview-window 'bottom:70%,border-top' \
      --height 70% \
      --info inline \
      --layout reverse \
      --bind 'enter:become(vim {1})'
}
# find string in files and open in vim
fs() {
  local rg_prefix='rg --column --line-number --no-heading --color=always --smart-case'
  local initial_query="${*:-}"

  : | fzf --ansi --disabled --query "$initial_query" \
      --bind "start:reload:$rg_prefix {q}" \
      --bind "change:reload:sleep 0.1; $rg_prefix {q} || true" \
      --delimiter ':' \
      --preview 'batcat --color=always {1} --highlight-line {2}' \
      --preview-window 'bottom:60%,border-top' \
      --layout reverse \
      --height 70% \
      --bind 'enter:become(vim {1} +{2})'
}
# Search and cd into the selected directory with smaller height and preview
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf \
    --height 33% \
    --info inline \
    --layout reverse \
    --preview 'ls -la {}' \
    --preview-window 'right:50%,border-left') &&
  cd "$dir"
}

source /home/test_beast/devenv/aichat.sh
export PATH="$HOME/zig-linux-x86_64-0.14.0-dev.2198+e5f5229fd:$PATH"
