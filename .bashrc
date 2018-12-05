#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable the lesspipe less preprocessor if installed
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Change the window title of X terminals
case ${TERM} in
  [aEkx]term*|rxvt*|gnome*|konsole*|interix)
    PS1='\[\033]0;\u@\h:\w\007\]'
    ;;
  screen*)
    PS1='\[\033k\u@\h:\w\033\\\]'
    ;;
  *)
    unset PS1
    ;;
esac

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Set a colorful prompt
if [[ ${EUID} == 0 ]] ; then
	PS1+='\[\033[01;31m\]\h\[\033[01;34m\] \w \$\[\033[00m\] '
else
	PS1+='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi

# Scripts in /etc/profile.d are only sourced for login shells. Explicitly
# source vte.sh to ensure that the Gnome virtual terminal emulator can feed
# itself extra information such as the current working directory.
if [ -f /etc/profile.d/vte.sh ]; then
  . /etc/profile.d/vte.sh
fi

if [ -f /usr/share/fzf/key-bindings.bash ]; then
  . /usr/share/fzf/key-bindings.bash
fi

if [ -f $HOME/z.sh ]; then
  . $HOME/z.sh
fi

# On Arch, wine defaults to a 64-bit environment. This is often not what you
# want.
export WINEARCH=win32

# Aliases
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cwget="wget --content-disposition"

export PATH="$HOME/bin:$PATH"
