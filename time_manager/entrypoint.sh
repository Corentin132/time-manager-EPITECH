#!/bin/bash

mix deps.get


mix ecto.setup

# if [ -z psql -Atqc "\\list $PGDATABASE" ]; then
# 	# psql -U postgres -c "CREATE DATABASE $PGDATABASE;"
# 	createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
#   mix ecto.migrate
#   mix run priv/repo/seeds.exs
#   echo "Database $PGDATABASE created."
# fi

# exec allows to replace current shell process with target command on same PID (here, 0)
exec mix phx.server