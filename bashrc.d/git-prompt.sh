# possibly go with the standard git prompt:
if false ; then
  GIT_PS1_SHOWCOLORHINTS=true
  [[ "$PROMPT_COMMAND" != *"__git_ps1"* ]] && export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ ";'" $PROMPT_COMMAND"
fi

# thanks from: http://aaroncrane.co.uk/2009/03/git_branch_prompt/
# may want to go with rev-parse instead of traversal.
# these can all be run in a single call
#
# git_dir=$(git rev-parse --git-dir)
# head=$(git rev-parse --symbolic-full-name HEAD)
# git_loc=$(git rev-parse --show_prefix)
# maybe: git --diff-files => git status -sb

function find_git_branch {
  local head git_dir=${PWD}
  local git_branch git_root git_loc git_status

  until [[ -z "$git_dir" || "$git_dir" = / ]] ; do
    if [[ -f "$git_dir/.git/HEAD" ]] ; then
      head=$(< "$git_dir/.git/HEAD")
    elif [[ -f "$git_dir/.git" ]] ; then
      local gitref=$(< "$git_dir/.git")
      head=$(< "${gitref#* }/HEAD")
    fi

    if [[ -n "$head" ]] ; then
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
      # also, they don't quite update until `git status` is run
      # note: these fail when running in .git directory
      if ! $(git diff-files --ignore-submodules --quiet 2> /dev/null) ; then
        git_status=31 # red - locally modified
      elif ! $(git diff-index --ignore-submodules --cached --quiet HEAD -- 2> /dev/null) ; then
        git_status=32 # green - staged
      else
        git_status=36 # cyan - pristine
      fi
      # TODO: git_status="\033[${git_status}m"
      PS1="\${git_branch:+[}\[\033[\${git_status}m\]\${git_branch}\[\033[0m\]\${git_branch:+] }\[\033[1;34m\]\${git_root}\[\033[0m\]\${git_loc} $ "
      return
    else # keep looking
      git_dir="${git_dir%/*}"
    fi
  done
  # not in a git directory (set variables accordingly)
  # TODO: git_status=\033[36m
  git_status=36
  git_branch=''
  git_root=''
  git_loc=${PWD##*/}
  PS1="\${git_branch:+[}\[\033[\${git_status}m\]\${git_branch}\[\033[0m\]\${git_branch:+] }\[\033[1;34m\]\${git_root}\[\033[0m\]\${git_loc} $ "
}

[[ "$PROMPT_COMMAND" != *"find_git_branch"* ]] && export PROMPT_COMMAND="find_git_branch${PROMPT_COMMAND:+ ; }${PROMPT_COMMAND}"
