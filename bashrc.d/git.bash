#!/bin/sh -x

# http://blog.hasmanythrough.com/2008/12/18/agile-git-and-the-story-branch-pattern
# http://reinh.com/blog/2008/08/27/hack-and-and-ship.html

alias gexport='git clone --bare -l .git ' #/pub/scm/proj.git'

# files that status shows from git
function gf() {
  local status=${*:-modified}
  git status | grep "${status}" | sed 's/^.*: *//'
}

# auto complete for git db
function _git_db { __gitcomp "$(git-db-complete $cur)" ; }

# usage:
#   git commit "$(author_from )"
# the quotes do not act as quoted
function author_from() {
  echo "--author=\"$(git log -1 --pretty='%an <%ae>' ${1?Need commit})\" --date=\"$(git log -1 --pretty=%ad $1)\""
}