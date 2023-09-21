CREATE role replicarole WITH REPLICATION ENCRYPTED PASSWORD 'SuperSecret' LOGIN;
select pg_reload_conf();
SELECT * FROM pg_create_physical_replication_slot('master');
select pg_drop_replication_slot('master');
\x
select * from pg_stat_replication ;
SELECT * FROM pg_create_physical_replication_slot('standby1');
select * from pg_stat_replication ;

