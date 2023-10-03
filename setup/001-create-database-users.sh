set -e
psql -U postgres -c "create role luca with login password  'LearnPostgreSQL' connection limit 1" postgres
psql -U postgres -c "create role enrico with login password 'LearnPostgreSQL'" postgres

