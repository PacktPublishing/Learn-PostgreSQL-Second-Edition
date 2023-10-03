# Prima macchina master
if [ "$SERVER_NAME" == "pg_master" ]; then
  { echo "host    replication     replicarole      0.0.0.0/0      trust"; } |  tee -a "$PGDATA/pg_hba.conf" > /dev/null
  psql -U postgres -c "select pg_reload_conf();SELECT * FROM pg_create_physical_replication_slot('master');" postgres
fi
#Seconda macchina slave
if [ "$SERVER_NAME" == "pg_replica" ]; then
  sleep 20
  pg_ctl -U postgres -D "$PGDATA" -m fast -w stop
  rm -rf $PGDATA/*
  pg_basebackup -h pg_master -U replicarole -p 5432 -D $PGDATA -Fp -Xs -P -R -W -S master
  chown -R postgres.postgres $PGDATA
  pg_ctl -U postgres -D "$PGDATA" start
fi
