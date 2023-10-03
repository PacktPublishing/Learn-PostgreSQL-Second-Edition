set -e
rm -rf /data/tablespaces 2>/dev/null
mkdir -p /data/tablespaces/ts_a
mkdir -p /data/tablespaces/ts_b
mkdir -p /data/tablespaces/ts_c

chown -R postgres:postgres /data/tablespaces

psql -U postgres -c "CREATE TABLESPACE ts_a LOCATION '/data/tablespaces/ts_a';" postgres
psql -U postgres -c "CREATE TABLESPACE ts_b LOCATION '/data/tablespaces/ts_b';" postgres
psql -U postgres -c "CREATE TABLESPACE ts_c LOCATION '/data/tablespaces/ts_c';" postgres
