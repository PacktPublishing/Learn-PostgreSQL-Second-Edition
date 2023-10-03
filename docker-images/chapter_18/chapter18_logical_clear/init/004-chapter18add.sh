if [ "$SERVER_NAME" == "pg_pub" ]; then
  { echo "host    replication     replicarole      0.0.0.0/0      trust"; } |  tee -a "$PGDATA/pg_hba.conf" > /dev/null
  #wal level to logical
  psql -U postgres -c "ALTER SYSTEM set wal_level = logical;" postgres
  psql -U postgres -c "ALTER SYSTEM set listen_addresses = '*';" postgres
  psql -U postgres -c "ALTER SYSTEM set max_replication_slots = 10;" postgres
  psql -U postgres -c "ALTER SYSTEM set max_wal_senders = 10;" postgres
  pg_ctl -U postgres -D "$PGDATA" -m fast -w stop
  pg_ctl -U postgres -D "$PGDATA" start
fi
if [ "$SERVER_NAME" == "pg_sub" ]; then
  sleep 10
  psql -U postgres -c "ALTER SYSTEM set max_logical_replication_workers = 4;" postgres
  psql -U postgres -c "ALTER SYSTEM set max_worker_processes=10;" postgres
  pg_ctl -U postgres -D "$PGDATA" -m fast -w stop
  pg_ctl -U postgres -D "$PGDATA" start
fi
