#alias debug='bundle exec rdebug -c -no-stop'
#alias irb='irb --readline -r irb/completion'
#alias beers='beer s'

#given a migration task, return the file name
#function mf() { ls db/migrate/*${1:?Please specify migration action}* ; }
#given a migration task, return the version
#e.g.: rake db:migrate:redo VERSION=$(mver create_photo)
#function mver() { mf $1 | sed 's=^[^0-9]*\([0-9][^_]*\)_.*$=\1=' ; }

