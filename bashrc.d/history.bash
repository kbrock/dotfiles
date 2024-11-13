
# if they have a term sessionid, then lets do a tab specific history
# works with mac iterm and terminal
if [ -n "$TERM_SESSION_ID" ] ; then
  export HISTFILE="$HOME/.bash_history_$TERM_SESSION_ID"
  [[ ! -e ${HISTFILE} && -f "${HOME}/.bash_history" ]] && cp "${HOME}/.bash_history" "$HISTFILE}"
fi
# append now rather than after exiting bash 
shopt -s histappend
