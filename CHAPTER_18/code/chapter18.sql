CREATE USER replicarole WITH REPLICATION ENCRYPTED PASSWORD 'LearnPostgreSQL';
create database db_source;
\c db_source
create table t1 (id integer not null primary key, name varchar(64));
GRANT SELECT ON ALL TABLES IN SCHEMA public TO replicarole;
CREATE PUBLICATION all_tables_pub FOR ALL TABLES;
create database db_destination;
\c db_destination 
create table t1 (id integer not null primary key, name varchar(64))
CREATE SUBSCRIPTION sub_all_tables CONNECTION 'user=replicarole password=LearnPostgreSQL host=pg_pub port=5432 dbname=db_source' PUBLICATION all_tables_pub;
insert into t1 values(1,'Linux'),(2,'FreeBSD');
select * from t1;
\x
select * from pg_stat_replication ;
select * from pg_stat_replication ;
select * from pg_publication;
select * from pg_subscription;
select * from t1;
select * from t1;
insert into t1 values (3,'OpenBSD');
select * from t1;
select * from t1;
insert into t1 values(4,'Minix');
select * from t1;
select * from t1;
insert into t1 values(3,'Windows');
select * from t1;
select * from t1;
insert into t1 values(5,'Unix');
select * from t1; 
select * from t1; 
select * from pg_stat_replication;
drop subscription sub_all_tables ;
truncate t1;
CREATE SUBSCRIPTION sub_all_tables CONNECTION 'user=replicarole password=LearnPostgreSQL host=pg_pub port=5432 dbname=db_source' PUBLICATION all_tables_pub;
select * from t1; 
select * from t1; 
select * from pg_stat_replication;
delete from t1 where id=5;
select * from t1;
select * from t1;
alter table t1 add description varchar(64);
select * from t1;
drop subscription sub_all_tables ;
alter subscription sub_all_tables SET (slot_name = NONE);
alter subscription sub_all_tables disable;
alter subscription sub_all_tables SET (slot_name = NONE);
drop subscription sub_all_tables ;

