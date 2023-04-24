#export PS1='$(git-PS1 "\W \$ ")'

# thinking maybe I should use the other

# thanks from: http://aaroncrane.co.uk/2009/03/git_branch_prompt/
function find_git_branch {
  local dir=. head
  git_dir=${PWD}
  #TODO: replace dir with git_dir and get rid of $dir
  until [ "$dir" -ef / ]; do
    if [ -f "$dir/.git/HEAD" ]; then
      head=$(< "$dir/.git/HEAD")
    elif [ -f "$dir/.git" ] ; then
      gitref=$(< "$dir/.git")
      head=$(< "${gitref#* }/HEAD")
    fi

    if [ -n "$head" ] ; then
      if [[ $head == ref:\ refs/heads/* ]]; then
        git_branch="${head#*/*/}"
      elif [[ $head != '' ]]; then
        git_branch='(detached)'
      else
        git_branch='(unknown)'
      fi
      git_root="${git_dir##*/}"
      git_loc="${PWD/${git_dir}}"

      # wish there was a way to do this not running all these commands
      # note: these fail when running in .git directory
      if ! $(git diff-files --ignore-submodules --quiet 2> /dev/null) ; then
        #locally modified
        git_status=31
      elif ! $(git diff-index --ignore-submodules --cached --quiet HEAD -- 2> /dev/null) ; then
        #committed, but not pushed
        git_status=32
      else
        git_status=36
      fi
      return
    else
      git_dir="${git_dir%/*}"
      dir="../$dir"
    fi
  done
# exported variables
  git_status=36
  git_dir=''
  git_branch=''
  git_root=''
  git_loc=${PWD##*/}
}

[[ "$PROMPT_COMMAND" != *"find_git_branch"* ]] && export PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"
#TODO: return status - emoji?
export PS1="\${git_branch:+[}\[\033[\${git_status}m\]\${git_branch}\[\033[0m\]\${git_branch:+] }\[\033[1;34m\]\${git_root}\[\033[0m\]\${git_loc} $ "
