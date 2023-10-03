# First container
if [ "$SERVER_NAME" == "pg_master_pub" ]; then
  { echo "host    replication     replicarole      0.0.0.0/0      trust"; } |  tee -a "$PGDATA/pg_hba.conf" > /dev/null
  #wal level to logical
  psql -U postgres -c "CREATE ROLE logicalreplicarole WITH REPLICATION LOGIN PASSWORD 'LearnPostgreSQL' " postgres
  psql -U postgres -c "ALTER SYSTEM set wal_level = logical;" postgres
  pg_ctl -U postgres -D "$PGDATA" -m fast -w stop
  pg_ctl -U postgres -D "$PGDATA" start
  #Grant on schema
  psql -U postgres -c "grant usage ON schema forum to logicalreplicarole;grant SELECT ON  forum.users to logicalreplicarole;" forumdb
  # Create physical replication slot
   psql -U postgres -c "SELECT * FROM pg_create_physical_replication_slot('master');" postgres
  # Create  publication
  psql -U postgres -c "create publication users_pub for table forum.users;" forumdb

fi
#Second container - physical replication
if [ "$SERVER_NAME" == "pg_replica" ]; then
  sleep 20
  psql -U postgres -c "ALTER SYSTEM set wal_level = logical;" postgres
  psql -U postgres -c "ALTER SYSTEM set hot_standby_feedback = on;" postgres
  pg_ctl -U postgres -D "$PGDATA" -m fast -w stop
  rm -rf $PGDATA/*
  pg_basebackup -h pg_master_pub -U replicarole -p 5432 -D $PGDATA -Fp -Xs -P -R -W -S master
  { echo "host    replication     logicalreplicarole     0.0.0.0/0      scram-sha-256"; } |  tee -a "$PGDATA/pg_hba.conf" > /dev/null
  chown -R postgres.postgres $PGDATA
  pg_ctl -U postgres -D "$PGDATA" start
fi

# Third Container - logical replication from physical replication
if [ "$SERVER_NAME" == "pg_replica_sub" ]; then
  sleep 30
  psql -U postgres -c "drop database forumdb;" postgres
  psql -U postgres -c "create database forumdb;" postgres
  psql -U postgres -c "alter database forumdb owner to forum" postgres
  psql -U postgres -c "CREATE SCHEMA forum AUTHORIZATION forum" forumdb
  psql -U postgres -c "CREATE TABLE forum.users (pk integer NOT NULL primary key,username text NOT NULL,gecos text, email text NOT NULL)" forumdb
  psql -U postgres -c "ALTER TABLE forum.users OWNER TO forum" forumdb
  psql -U postgres -c "create subscription users_sub connection 'user=logicalreplicarole password=LearnPostgreSQL host=pg_replica port=5432 dbname=forumdb' publication users_pub" forumdb
fi
