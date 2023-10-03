set -e
psql -U postgres -c "create role luca with login password  'LearnPostgreSQL'" postgres
psql -U postgres -c "create role enrico with login password 'LearnPostgreSQL'" postgres
