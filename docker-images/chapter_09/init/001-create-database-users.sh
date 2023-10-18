set -e
psql -U postgres -c "alter role postgres password 'LearnPostgreSQL'" postgres
psql -U postgres -c "create role luca with login password  'LearnPostgreSQL'" postgres
psql -U postgres -c "create role enrico with login password 'LearnPostgreSQL'" postgres
sudo chown postgres:postgres /data/tablespaces/ts_a 
sudo chown postgres:postgres /data/tablespaces/ts_b
sudo chown postgres:postgres /data/tablespaces/ts_c
