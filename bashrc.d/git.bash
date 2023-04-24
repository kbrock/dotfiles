#!/bin/sh -x

# http://blog.hasmanythrough.com/2008/12/18/agile-git-and-the-story-branch-pattern
# http://reinh.com/blog/2008/08/27/hack-and-and-ship.html


# alias ga='git add . -v'
#alias gb='git branch -v'

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

function _gpo_complete {
  COMPREPLY=($(compgen -W "$(git remote)" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}
complete -o nospace -F _gpo_complete gpo

# files that status shows from git
function gf() {
  local status=${*:-modified}
  git status | grep "${status}" | sed 's/^.*: *//'
}

# auto complete for git db
function _git_db { __gitcomp "$(git-db-complete $cur)" ; }

# files that have changed from master
function gn() {
  git diff master --name-only
}

#bring this bug up to date
function bug_rebase() {
  local CURRENT=${1:-git curren-branch}
  git checkout master
  git pull origin master --rebase
  git checkout ${CURRENT}
  git rebase master
}
