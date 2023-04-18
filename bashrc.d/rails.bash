#alias mig='rake db:migrate db:test:prepare'
#alias tl='touch log/development.log ; tail -f log/development.log'
#alias debug='bundle exec rdebug -c -no-stop'
alias gems='gem list'
alias irb='irb --readline -r irb/completion'
alias beers='beer s'
alias burps='RAILS_ENV=production beer s'
alias burp='RAILS_ENV=production beer'
alias bu='ruby -I~/dotfiles/ -rbundler_trap bin/bundle update'

#given a migration task, return the file name
function mf() { ls db/migrate/*${1:?Please specify migration action}* ; }
#given a migration task, return the version
#e.g.: rake db:migrate:redo VERSION=$(mver create_photo)
function mver() { mf $1 | sed 's=^[^0-9]*\([0-9][^_]*\)_.*$=\1=' ; }

function ruby-version {
  if [ $# -eq 1 ] ; then
    chruby $1
  fi
  local rv=`chruby | awk '/\*/ { print $2; }'`
  if [ -n "$rv" ] ; then
    echo $rv > .ruby-version

    which ruby
  else
    echo "please pick a ruby"
    chruby
  fi
}
complete -o nospace -F _chrubycomplete ruby-version


# function powrc {
# [ -f .powrc] && return
# cat <<EOF > .powrc
# source /usr/local/share/chruby/chruby.sh
# [ -f .ruby-version ] && chruby \$(cat .ruby-version)
# [ -f .env ] && export \$(cat .env)
# EOF
# }

# Cucumber env setting 
export AUTOFEATURE=true	

#ree settings
#export RUBY_HEAP_MIN_SLOTS=600000
#export RUBY_GC_MALLOC_LIMIT=59000000
#export RUBY_HEAP_FREE_MIN=100000
#export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
#export RUBY_HEAP_SLOTS_INCREMENT=1

