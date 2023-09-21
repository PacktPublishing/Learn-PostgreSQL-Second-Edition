sh run-pg-docker.sh chapter17_streaming
bash run-pg-docker_replica.sh chapter17_streaming
bash run-pg-docker.sh chapter17_synchoronous
bash run-pg-docker_replica.sh chapter17_synchoronous
bash run-pg-docker.sh chapter17_delayed
bash run-pg-docker_replica.sh chapter17_delayed
ls -alh
ip addr
su - postgres
psql 
ip addr
su - postgres
psql
ping 192.168.122.11
ping 192.168.122.10
systemctl stop postgresql
cd /var/lib/postgresql/16/
rm -rf main
mkdir main
chown postgres:postgres main
chmod 0700 main
su - postgres 
cd /var/lib/PostgreSQL/16/main
pg_basebackup -h 192.168.122.10 -U replicarole -p5432 -D /var/lib/PostgreSQL/16/main -Fp -Xs -P -R -S master
checkpoint ;
cat postgresql.auto.conf 
systemctl start postgresql
\l
systemctl reload postgresql
systemctl stop postgresql
rm -rf /var/lib/postgresql/16/main/*
pg_basebackup -h 192.168.122.11 -U replicarole -p 5432 -D /var/lib/PostgreSQL/16/main -Fp -Xs -P -R -S standby1
systemctl start postgresql
systemctl reload postgresql
pg_ctl promote -D /var/lib/PostgreSQL/16/main
