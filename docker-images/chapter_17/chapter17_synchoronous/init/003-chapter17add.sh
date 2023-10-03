# Prima macchina master
if [ "$SERVER_NAME" == "pg_master" ]; then
  { echo "host    replication     replicarole      0.0.0.0/0      trust"; } |  tee -a "$PGDATA/pg_hba.conf" > /dev/null
  psql -U postgres -c "select pg_reload_conf();SELECT * FROM pg_create_physical_replication_slot('master');" postgres
  psql -U postgres -c "alter system set synchronous_standby_names='pg2';" postgres
  psql -U postgres -c "alter system set synchronous_commit = 'on';" postgres
  pg_ctl -U postgres -D "$PGDATA" -m fast -w stop
  pg_ctl -U postgres -D "$PGDATA" start
fi
#Seconda macchina slave
if [ "$SERVER_NAME" == "pg_replica" ]; then
  sleep 20
  pg_ctl -U postgres -D "$PGDATA" -m fast -w stop
  rm -rf $PGDATA/*
  pg_basebackup -h pg_master -U replicarole -p 5432 -D $PGDATA -Fp -Xs -P -R -W -S master
  chown -R postgres.postgres $PGDATA
  pg_ctl -U postgres -D "$PGDATA" start
  psql -U postgres -c "alter system set primary_conninfo = 'user=replicarole password=SuperSecret channel_binding=disable host=pg_master port=5432 sslmode=disable sslcompression=0  sslsni=1 ssl_min_protocol_version=TLSv1.2 gssencmode=disable krbsrvname=postgres target_session_attrs=any application_name=pg2';" postgres
  pg_ctl -U postgres -D "$PGDATA" -m fast -w stop
  pg_ctl -U postgres -D "$PGDATA" start
fi
