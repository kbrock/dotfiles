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
  if [ -d "$1" ] && ! echo ":${PATH}:" | grep ":${1}:" > /dev/null ; then
    return 0
  else
    return 1
  fi
}

function add_to_path() {
  not_in_path "$1" && export PATH="$PATH:$1"
}

# this adds brew, so brew --prefix works for all others
not_in_path "/opt/homebrew/bin" && export PATH="/opt/homebrew/bin:$PATH"
# probably not necessary
add_to_path /usr/local/bin

# if we have homebrew installed, but not running homebrew bash
if $(which -s brew) && [[ "$SHELL" = "/bin/bash" ]]; then
  echo
  echo -e "\033[31mwarning\033[0m using non-homebrew ${SHELL}. \033[31mrun\033[0m:"
  grep -q $(which bash) /etc/shells || echo "sudo echo \$(which bash) >> /etc/shells"
  echo "chsh -s \$(which bash)"
  echo
fi
