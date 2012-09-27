#http://www.debian-administration.org/article/317/An_introduction_to_bash_completion_part_2
# http://linux.about.com/library/cmd/blcmdl1_compgen.htm
function _psql_database_complete {
  COMPREPLY=($(compgen -W "$(psql -l | awk -F\| '/\|/ {print $1}')" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

function _psqlcomplete {
  local cur prev opts
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  #compgen
  # -f          : file
  # -A hostname : hostname
  #  a alias b builtin c command d directory e export [variable]
  #  f file  g group   j job     k keyword   u user v variable
  # ? -s

  if [ ${prev} = -U ] ; then
    COMPREPLY=( $(compgen -W "postgres" -- ${cur}) )
    return 0
  fi

  _psql_database_complete
  return 0
}
#not 100%, but close
complete -o default -o nospace -F _psqlcomplete psql
complete -o default -o nospace -F _psqlcomplete dropdb
complete -o default -o nospace -F _psqlcomplete createdb
complete -o default -o nospace -F _psql_database_complete ptop
complete -o default -o nospace -F _psql_database_complete gitdb
complete -o default -o nospace -F _psql_database_complete pmv
