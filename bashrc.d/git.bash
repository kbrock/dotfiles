#!/bin/sh -x

# http://blog.hasmanythrough.com/2008/12/18/agile-git-and-the-story-branch-pattern
# http://reinh.com/blog/2008/08/27/hack-and-and-ship.html


# alias ga='git add . -v'
#alias gb='git branch -v'

#export PS1='$(git-PS1 "\W \$ ")'

function gb() {
  case $1 in
    "") git branch ;;
    "-a") git branch -a ;;
    *) git checkout -b $1 ;;
  esac
}
alias gs='git status'
alias gd='git diff'
alias gg='git grep'
alias gdd='chdiff --local-scm'
# alias gdm='git diff | mate'
#alias gcob='git checkout -b'
# alias gl='git log --pretty=oneline'
# alias gls='git log --stat'
# alias gsr='git svn rebase'
# alias gsd='git svn dcommit --edit'
# alias gitx='gitx --all &'
# alias gitk='gitk --all &'

alias gexport='git clone --bare -l .git ' #/pub/scm/proj.git'

alias gpr='git pull --rebase'
alias gpo='git push origin HEAD'

# files that status shows from git
function gf() {
  status=${*:-unmerged}
  git status | grep "${status}" | sed 's/^.*: *//'
}

alias branch_name="git branch | awk '/^\*/{print \$2}'"

#bring this bug up to date
function bug_rebase() {
  local CURRENT=${1:-`branch_name`}
  git checkout master
  git pull origin master --rebase
  git checkout ${CURRENT}
  git rebase master
}

# thanks from: http://aaroncrane.co.uk/2009/03/git_branch_prompt/
function find_git_branch {
  local dir=. head
  git_dir=${PWD}
  #TODO: replace dir with git_dir and get rid of $dir
  until [ "$dir" -ef / ]; do
    if [ -f "$dir/.git/HEAD" ]; then
      head=$(< "$dir/.git/HEAD")
      if [[ $head == ref:\ refs/heads/* ]]; then
        git_branch="${head#*/*/}"
      elif [[ $head != '' ]]; then
        git_branch='(detached)'
      else
        git_branch='(unknown)'
      fi
      git_root="${git_dir##*/}"
      git_loc="${PWD/${git_dir}}"

      #wish there was a way to do this not running all these commands
      if ! $(git diff-files --ignore-submodules --quiet) ; then
        #locally modified
        git_status=32
      elif ! $(git diff-index --cached --quiet HEAD --) ; then
        #committed, but not pushed
        git_status=33
      else
        git_status=36
      fi
      return
    fi
    git_dir="${git_dir%/*}"
    dir="../$dir"
  done
# exported variables
  git_status=36
  git_dir=''
  git_branch=''
  git_root=''
  git_loc=${PWD##*/}
}
export PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"
export PS1="\${git_branch:+[}\[\033[\${git_status}m\]\${git_branch}\[\033[0m\]\${git_branch:+] }\[\033[1;34m\]\${git_root}\[\033[0m\]\${git_loc} $ "
# # sneaking some svn commands in here
# 
# function git2svn() {
#   if [ ! -d .git ] ; then
#     echo "need to run this from the root directory"
#     exit 1
#   fi
#   svn_name=${1:?need an svn project name}
#   SVN_ROOT=svn+ssh://svn.eons.dev/opt/svn/repo/${svn_name}
#   svn mkdir ${SVN_ROOT} ${SVN_ROOT}/trunk ${SVN_ROOT}/branches ${SVN_ROOT}/tags
# 
#   git svn init -s $SVN_ROOT
#   git svn fetch
#   #git checkout -b svnrebase trunk
#   git rebase --onto trunk --root master
#   git svn dcommit
#   #git push origin
# }

