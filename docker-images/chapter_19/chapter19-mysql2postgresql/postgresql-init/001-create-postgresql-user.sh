set -e
createuser -s postgres -U user
psql -U postgres -c "CREATE USER replicarole WITH REPLICATION ENCRYPTED PASSWORD 'LearnPostgreSQL'" postgres
psql -U postgres -c "alter role postgres password 'st'" postgres
pg_ctl -U postgres -D "$PGDATA" -m fast -w stop
pg_ctl -U postgres -D "$PGDATA" start
