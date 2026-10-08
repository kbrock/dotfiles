#export PGHOST=localhost
#export PGUSER=postgres
#export PGPASSWORD=postgres
#export PGDATABASE=vmdb_development
# libpq is keg only. use its psql unless a full postgres is installed
not_defined psql && add_to_path "${HOMEBREW_PREFIX}/opt/libpq/bin"
alias pps='ps -xa | grep postgres'
