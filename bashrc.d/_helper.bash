#helper functions
#if this function is not available

function not_defined {
  if `type -a "$1" >/dev/null 2>&1` ; then
    return 1
  else
    return 0
  fi
}

#if we need to add this path to our environment
function not_in_path {
  if [[ -d "$1" && ":${PATH}:" != *:${1}:* ]] ; then
    return 0
  else
    return 1
  fi
}

function add_to_path() {
  not_in_path "$1" && export PATH="$PATH:$1"
}

# adds homebrew to PATH and HOMEBREW_PREFIX
[[ -f /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
add_to_path /usr/local/bin

# if we have homebrew installed, but not running homebrew bash
if [[ "$SHELL" = "/bin/bash" && -n "$HOMEBREW_PREFIX" ]] ; then
  echo
  echo -e "\033[31mwarning\033[0m using non-homebrew ${SHELL}. \033[31mrun\033[0m:"
  grep -q $(which bash) /etc/shells || echo "sudo echo \$(which bash) >> /etc/shells"
  echo "chsh -s \$(which bash)"
  echo
fi
