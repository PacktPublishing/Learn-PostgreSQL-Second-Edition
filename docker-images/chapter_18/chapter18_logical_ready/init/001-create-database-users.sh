set -e
psql -U postgres -c "CREATE USER replicarole WITH REPLICATION ENCRYPTED PASSWORD 'LearnPostgreSQL'" postgres
psql -U postgres -c "alter role postgres password 'LearnPostgreSQL'" postgres
psql -U postgres -c "create role luca with login password  'LearnPostgreSQL'" postgres
psql -U postgres -c "create role enrico with login password 'LearnPostgreSQL'" postgres
