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
function cw() { local dn="$(dirname $(which $1))" ; [ -d "$dn" ] && pushd $dn ; }
#copy in the background (add an & in there?)
function bgcp { cp "$@" && ding copied || ding failed ; }

function sag() {
  subl $(ag -l "$@")
}

# open bob all the files we found in ag (like sublime ag)
function cag() {
  bobide $(ag -l "$@")
}

# ag for all miq files
function mag() {
  # ignore: bluecf, gems, plugins/providers files
  ag "$@" ~/src/{amazon,container,dbus,httpd,ibm,inventory,manageiq,miq,ui,vmware}* ~/src/gems/{more_core_extensions,manage}*
}

# mag for markdown
function magm() {
  local ROOT=~/src # and src/gems (hence that gems gook)
  # ag --ruby 'def (self\.)?(search|find)\b' $ROOT/* | ruby -ne "f,l,*s=\$_.split(':');s=s.join(':').strip; m=f.match(%r{^.*${ROOT}(/gems)?/([^/]*)(/.*)$}); _,d,p=m[1..3]; fn=p.split('/').last; puts \"\`#{s.chomp}\` [#{fn}](https://github.com/ManageIQ/#{d}/blob/master#{p}#L#{l})\""
  mag --ruby "$@" | ruby -ne "f,l,*s=\$_.split(':');s=s.join(':').strip; m=f.match(%r{^.*${ROOT}(/gems)?/([^/]*)(/.*)$}); _,d,p=m[1..3]; fn=p.split('/').last; puts \"\`#{s.chomp}\` [#{d}:#{fn}:#{l}](https://github.com/ManageIQ/#{d}/blob/master#{p}#L#{l})\""
}
# mag for markdown slack
function magms() {
  local ROOT=~/src # and src/gems (hence that gems gook)
  # technically fn is not needed. kept to keep magm and magms as similar as possible
  mag --ruby "$@" | ruby -ne "f,l,*s=\$_.split(':');s=s.join(':').strip; m=f.match(%r{^.*${ROOT}(/gems)?/([^/]*)(/.*)$}); _,d,p=m[1..3]; fn=p.split('/').last; puts \"\`#{s.chomp}\` https://github.com/ManageIQ/#{d}/blob/master#{p}#L#{l}\""
}

function magg() {
  # -G says only ruby files (^c = spec)
  mag "$@" --ignore '*_spec.rb'
}

# ? maybe magg (ignoring specs) is what we want instead?
function marge() {
  ag "$@" ~/src/manageiq/{app,lib/vmdb} ~/src/manageiq-*/lib
}

if [ -d ~/.Trash ] ; then
function rm () {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    elif [ -e "$path" ] ; then
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      mv "$path" ~/.Trash/"$dst"
    else
      echo "smart rm: $path: No such file or directory"
    fi
  done
}
fi
