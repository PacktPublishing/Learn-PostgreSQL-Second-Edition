# Prima macchina master
if [ "$SERVER_NAME" == "pg_pub" ]; then
  { echo "host    replication     replicarole      0.0.0.0/0      trust"; } |  tee -a "$PGDATA/pg_hba.conf" > /dev/null
  #wal level to logical
  psql -U postgres -c "ALTER SYSTEM set wal_level = logical;" postgres
  pg_ctl -U postgres -D "$PGDATA" -m fast -w stop
  pg_ctl -U postgres -D "$PGDATA" start
  # Grant select permission di replicarole user
  psql -U postgres -c "grant usage ON schema forum TO replicarole ;" forumdb
  psql -U postgres -c "grant SELECT on ALL tables in schema forum to replicarole ;" forumdb
  # Create  publication
  psql -U postgres -c "create publication users_pub for table forum.users;" forumdb
fi
#Seconda macchina slave
if [ "$SERVER_NAME" == "pg_sub" ]; then
  sleep 10
  psql -U postgres -c "drop database forumdb;" postgres
  psql -U postgres -c "create database forumdb;" postgres
  psql -U postgres -c "alter database forumdb owner to forum" postgres
  psql -U postgres -c "CREATE SCHEMA forum AUTHORIZATION forum" forumdb
  psql -U postgres -c "CREATE TABLE forum.users (pk integer NOT NULL primary key,username text NOT NULL,gecos text, email text NOT NULL)" forumdb
  psql -U postgres -c "ALTER TABLE forum.users OWNER TO forum" forumdb
  psql -U postgres -c "create subscription users_sub connection 'user=replicarole password=LearnPostgreSQL host=pg_pub port=5432 dbname=forumdb' publication users_pub" forumdb
fi
