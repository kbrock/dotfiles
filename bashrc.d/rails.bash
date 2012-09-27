alias sc='script/console'
#alias sg='script/generate'
#alias mig='rake db:migrate db:test:prepare'
#alias tl='tail -f log/development.log'
#alias debug='bundle exec rdebug -c -no-stop'
alias sat='bundle exec ~/bin/search_and_test.rb'
alias gems='gem list'
alias irb='irb --readline -r irb/completion'
alias bake='bundle exec rake'
alias beer='bundle exec ruby'
alias cuke='RAILS_ENV=cucumber bundle exec cucumber'
#may want to add
alias spec='ruby -Ispec -J-d32'

#given a migration task, return the file name
function mf() { ls db/migrate/*${1:?Please specify migration action}* ; }
#given a migration task, return the version
#e.g.: rake db:migrate:redo VERSION=$(mver create_photo)
function mver() { mf $1 | sed 's=^[^0-9]*\([0-9][^_]*\)_.*$=\1=' ; }

# Cucumber env setting 
export AUTOFEATURE=true	
#export RSPEC=true

#ree settings
#export RUBY_HEAP_MIN_SLOTS=600000
#export RUBY_GC_MALLOC_LIMIT=59000000
#export RUBY_HEAP_FREE_MIN=100000
#export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
#export RUBY_HEAP_SLOTS_INCREMENT=1

