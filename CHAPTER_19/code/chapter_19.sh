bash run-pg-docker.sh chapter19-pg_trgm
psql -U forum forumdb
bash run-pg-docker.sh chapter19-postgresql_fdw
psql -U forum forumdb
bash run-pg-docker-pg_fdw2.sh chapter19-postgresql_fdw
psql -U forum forumdb
psql -U postgres forumdb
psql -U forum forumdb
ssh-keygen -t rsa -b 4096
ssh-keygen -t rsa -b 4096
ls -l
ls -l
ssh-copy-id 192.168.122.120
ssh-copy-id 192.168.122.170
apt-get update
apt-get update
apt-get install pgbackrest
apt-get install pgbackrest
systemctl restart postgresql
pgbackrest --stanza=pg1 stanza-create
ls -l
pgbackrest --stanza=pg1 check
pgbackrest --stanza=pg1 --type=full backup
pgbackrest --stanza=pg1 info
pgbackrest --stanza=pg1 --type=incr backup
pgbackrest --stanza=pg1 --type=diff backup
pgbackrest --stanza=pg1 info
pgbackrest --stanza=pg1 --type=full backup
pgbackrest --stanza=pg1 --type=full backup
pgbackrest --stanza=pg1 info
systemctl start postgresql
su - postgres
pgbackrest --stanza=pg1 --delta --log-level-console=info --type=time "--target=2023-07-11 08:55:08" restore
systemctl start postgresql
