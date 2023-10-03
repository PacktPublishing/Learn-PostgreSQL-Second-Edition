set -e
psql -U postgres -c "CREATE TABLESPACE ts_a LOCATION '/data/tablespaces/ts_a';" postgres
psql -U postgres -c "CREATE TABLESPACE ts_b LOCATION '/data/tablespaces/ts_b';" postgres
psql -U postgres -c "CREATE TABLESPACE ts_c LOCATION '/data/tablespaces/ts_c';" postgres
