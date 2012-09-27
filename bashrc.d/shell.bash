
#helper functions
#if this function is not available
function not_defined() {
#	return `which $1 |grep -v "^no ">/dev/null`
  if `which $1 >/dev/null` ; then
    return 1
  else
    return 0
  fi
}

#if we need to add this path to our environment
function not_in_path {
  if [ -d $1 ] && ! echo $PATH | grep $1 > /dev/null ; then
    return 0
  else
    return 1
  fi
}

NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules
export LC_CTYPE=en_US.UTF-8
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1 

#unix commands
alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -lah'
alias dir='ls -lh'
alias rrm='rm -rf'
alias ds='du -sk * |sort -nr'
#-r for more allows "raw" to come through -i.e.: tty color
alias more='less -r'
alias mroe='less -r'
alias wget='curl -O'
alias growl='growlnotify -m'

#mac only
not_defined 'ldd' && alias ldd='otool -L'
not_in_path ~/bin && export PATH=$PATH:~/bin

function title() { echo -e "\033];${1:?please specify a title}\007" ; }
function mw() { more  `which $1` ; }
function lw() { ls -l `which $1` ; }
function sw() { subl  `which $1` ; }
function vw() { vi    `which $1` ; }

#copy in the background (add an & in there?)
function bgcp { cp "$@" && ding copied || ding failed ; }

#mate each argument. so they end up in the existing editor
function mate() {
  mexe=$(which mate)
  if [ $# -eq 0 ] ; then
    $mexe
  else
    while [ $# -ne 0 ] ; do
      $mexe "$1"
      shift
    done
  fi
}

if [ -d ~/.Trash ] ; then
function rm () {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      mv "$path" ~/.Trash/"$dst"
    fi
  done
}
fi
