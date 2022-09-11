export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"

alias postgres='postgres -k "$PGHOST"'
alias kill-postgres='sudo kill -9 postgres'
