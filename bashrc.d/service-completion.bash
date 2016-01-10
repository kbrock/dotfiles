_service_completion() {
  local cur prev target opts commands
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  opts="list start load stop unload fix vi edit subl install"

  if [[ $opts =~ "${prev}" ]] ; then
    commands=( ~/Library/LaunchAgents/* )
    # gsub('.plist','').split('.').last
    commands2=( ${commands[*]%.plist} )
    commands2=( ${commands2[*]##*.} )

    COMPREPLY=( $(compgen -W "${commands2[*]}" -- ${cur}) )
    return 0
  fi

  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}
complete -F _service_completion service
