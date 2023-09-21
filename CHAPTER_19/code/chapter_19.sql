set enable_seqscan to 'off';
select pk,title from categories;
create index on categories using btree(title varchar_pattern_ops);
explain analyze select * from categories where title like 'Da%';
explain analyze select * from categories where title like '%Da%';
create extension pg_trgm;
create index  on categories using gin (title gin_trgm_ops);
explain analyze select * from categories where title like 'Da%';
select * from categories;
create extension postgres_fdw ;
CREATE SERVER remote_pg_fdw2 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'pg_fdw2', dbname 'forumdb');
CREATE USER MAPPING FOR forum SERVER remote_pg_fdw2 OPTIONS (user 'forum', password 'LearnPostgreSQL');
create foreign table forum.f_categories (
      pk integer,
      title text,
      description text
)
SERVER remote_pg_fdw2 OPTIONS (schema_name 'forum', table_name 'categories'); 
grant SELECT ON forum.f_categories to forum;
select * from f_categories ;
create table users (id integer, user_name text);
insert into users select generate_series(1,10000),'user_'||generate_series(1,10000)::text;
select now();
drop table users;
select pg_wal_replay_resume();
\d
select count(*) from users ;
