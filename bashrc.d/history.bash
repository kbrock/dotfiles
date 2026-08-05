
# if they have a term sessionid, then lets do a tab specific history
# works with mac iterm and terminal
# if [ -n "$TERM_SESSION_ID" ] ; then
#   export HISTFILE="$HOME/.bash_history_$TERM_SESSION_ID"
#   [[ ! -e ${HISTFILE} && -f "${HOME}/.bash_history" ]] && cp "${HOME}/.bash_history" "$HISTFILE}"
# fi
# append now rather than after exiting bash
shopt -s histappend

# history and title
function ttitle() {
  title ${*:?please specify a title}
  local filename="${*//[^a-zA-Z]/}"
  # [[ ! -e ${HISTFILE} && -f "${HOME}/.bash_history" ]] && cp "${HOME}/.bash_history" "$HISTFILE}"
  export HISTFILE="${HOME}/.bash_history_files/${filename}"
}

function _ttitle_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$(ls ~/.bash_history_files 2>/dev/null)" -- "$cur") )
}
complete -F _ttitle_complete ttitle
