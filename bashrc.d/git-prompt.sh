# thanks from: http://aaroncrane.co.uk/2009/03/git_branch_prompt/

function find_git_branch {
  local head gd gitref git_dir=${PWD}
  local git_branch git_root git_loc git_status git_state
  local out line staged unstaged

  until [[ -z "$git_dir" || "$git_dir" = "/" ]] ; do
    gd=''
    head=''
    if [[ -f "$git_dir/.git/HEAD" ]] ; then
      gd="$git_dir/.git"
    elif [[ -f "$git_dir/.git" ]] ; then
      gitref=$(< "$git_dir/.git")
      gd=${gitref#gitdir: }
      [[ $gd == /* ]] || gd="$git_dir/$gd"
    elif [[ "$git_dir" == "$HOME" ]] ; then
      git_root="~"
      git_loc="${PWD/${git_dir}}"
      PS1="\[\033[1;34m\]${git_root}\[\033[0m\]${git_loc} $ "
      return
    fi
    [[ -n "$gd" && -f "$gd/HEAD" ]] && head=$(< "$gd/HEAD")

    if [[ -n "$head" ]] ; then
      if [[ $head == ref:\ refs/heads/* ]]; then
        git_branch="${head#ref: refs/heads/}"
      else
        git_branch="${head:0:7}" # detached: short sha
      fi
      git_root="${git_dir##*/}"
      git_loc="${PWD/${git_dir}}"

      if [[ -d "$gd/rebase-merge" || -d "$gd/rebase-apply" ]] ; then
        git_state='|REBASE'
      elif [[ -f "$gd/MERGE_HEAD" ]] ; then
        git_state='|MERGE'
      fi

      if out=$(GIT_OPTIONAL_LOCKS=0 git status --porcelain=v1 --untracked-files=no --ignore-submodules 2> /dev/null) ; then
        while IFS= read -r line ; do
          [[ -z "$line" ]] && continue
          [[ "${line:1:1}" != ' ' ]] && { unstaged=1 ; break ; }
          [[ "${line:0:1}" != ' ' ]] && staged=1
        done <<< "$out"
        if [[ -n "$unstaged" ]] ; then
          git_status=31 # red - locally modified
        elif [[ -n "$staged" ]] ; then
          git_status=32 # green - staged
        else
          git_status=36 # cyan - pristine
        fi
      else
        git_status=0 # status failed (e.g. inside .git): no color
      fi
      PS1="[\[\033[${git_status}m\]${git_branch}\[\033[0m\]${git_state}] \[\033[1;34m\]${git_root}\[\033[0m\]${git_loc} $ "
      return
    else # keep looking
      git_dir="${git_dir%/*}"
    fi
  done
  # not in a git directory (set variables accordingly)
  PS1="${PWD##*/} $ "
}

[[ "$PROMPT_COMMAND" != *"find_git_branch"* ]] && export PROMPT_COMMAND="find_git_branch${PROMPT_COMMAND:+ ; }${PROMPT_COMMAND}"
