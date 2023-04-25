export LC_CTYPE=en_US.UTF-8
export GREP_COLOR='1;32'
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
# would alias to which, but
alias whereis='type -a'
# gem install terminal-notifier
alias growl='terminal-notifier -message'

#mac only
not_defined 'ldd' && alias ldd='otool -L'
add_to_path ~/bin

function title() { echo -e "\033]0;${1:?please specify a title}\007" ; }
#javascript alert dialog
function alert() {
  message="$1"
  title="${2-Alert}"
  osascript -e "tell app \"System Events\" to display alert \"${title}\" message \"${message}\""
}
function notify {
  message="${1}"
  title="${2-Alert}"
  osascript -e "display notification \"${message}\" with title \"${title}\"" }
}

function mw() { more  `which $1` ; }
function catw() { cat `which $1` ; }
function lw() { ls -l `which $1` ; }
function sw() { subl  `which $1` ; }
function vw() { vi    `which $1` ; }
function cw() { cd $(dirname $(which $1)) ; }
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

#you just ran ack, now sack to sublime the files
function sack() {
  subl $(ack -l "$@")
}

function sag() {
  subl $(ag -l "$@")
}

function mag() {
  ag "$@" --ignore gems --ignore bluecf ~/src/
}

function magg() {
  # -G says only ruby files (^c = spec)
  ag "$@" --ignore '*_spec.rb' ~/src/
} 

function marge() {
  ag "$@" ~/src/manageiq/{app,lib/vmdb} ~/src/manageiq-*/lib
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
