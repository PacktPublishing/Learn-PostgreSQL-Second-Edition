bash run-pg-docker.sh chapter18_logical_clear
bash run-pg-docker_replica.sh chapter18_logical_clear
ping pg_sub
ping pg_pub
systemctl restart postgresql
netstat -an | grep 5432
systemctl restart postgresql
netstat -an | grep 5432
systemctl reload postgresql
bash run-pg-docker-replica-logical.sh chapter18_physical_logical
bash run-pg-docker-replica1.sh chapter18_physical_logical
bash run-pg-docker-replica2.sh chapter18_physical_logical
select * from pg_stat_replication;
select * from pg_stat_replication;
select * from forum.users;
select * from forum.users;
select * from forum.users;
delete from forum.users ;
select * from forum.users ;
delete from forum.users where pk =1 ;
select * from forum.users;
