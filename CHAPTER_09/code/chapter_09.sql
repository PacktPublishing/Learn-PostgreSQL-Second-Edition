create table table_a (
pk integer not null primary key,
tag text,
parent integer);

create table table_b () inherits (table_a);
alter table table_b add constraint table_b_pk primary key(pk);
\d table_a;
\d+ table_a;
\d table_b;

insert into table_a (pk,tag,parent) values (1,'Operating Systems',0);

insert into table_b (pk,tag,parent) values (2,'Linux',0);

select * from table_b ;

select * from table_a ;

select * from only  table_a ;

update table_a set tag='BSD Unix' where pk=2;

select * from table_b;

delete from table_a where pk=2;

select * from table_a;

select * from table_b;

drop table table_b;

drop table table_a cascade;

CREATE TABLE part_tags (
pk SERIAL NOT NULL , 
level INTEGER NOT NULL DEFAULT 0,
tag VARCHAR (255) NOT NULL,
primary key (pk,level)
)
PARTITION BY LIST (level);

CREATE TABLE part_tags_level_0 PARTITION OF part_tags FOR VALUES IN (0);

CREATE TABLE part_tags_level_1 PARTITION OF part_tags FOR VALUES IN (1);

CREATE TABLE part_tags_level_2 PARTITION OF part_tags FOR VALUES IN (2);

CREATE TABLE part_tags_level_3 PARTITION OF part_tags FOR VALUES IN (3);

CREATE INDEX on part_tags (tag);

\d part_tags;

\d part_tags_level_0;

insert into part_tags (tag,level) values ('Operating System',0);

insert into part_tags (tag,level) values ('Linux',1);

insert into part_tags (tag,level) values ('BSD Unix',1);

insert into part_tags (tag,level) values ('DOS',1);

insert into part_tags (tag,level) values ('Windows',2);

select * from part_tags;

select * from part_tags_level_0; 

select * from part_tags_level_1;

select * from part_tags_level_2;

DROP TABLE IF EXISTS part_tags cascade;

CREATE TABLE part_tags (
pk serial NOT NULL,
ins_date date not null default now()::date,
tag VARCHAR (255) NOT NULL,
level INTEGER NOT NULL DEFAULT 0,
primary key (pk,ins_date)
)
PARTITION BY RANGE (ins_date);

CREATE TABLE part_tags_date_01_2023 PARTITION OF part_tags FOR VALUES FROM ('2023-01-01') TO ('2023-01-31');

CREATE TABLE part_tags_date_02_2023 PARTITION OF part_tags FOR VALUES FROM ('2023-02-01') TO ('2023-02-28');

CREATE TABLE part_tags_date_03_2023 PARTITION OF part_tags FOR VALUES FROM ('2023-03-01') TO ('2023-03-31');

CREATE TABLE part_tags_date_04_2023 PARTITION OF part_tags FOR VALUES FROM ('2023-04-01') TO ('2023-04-30');

CREATE INDEX on part_tags(tag);

\d part_tags;

\d part_tags_date_01_2023;


insert into part_tags (tag,ins_date,level) values ('Operating Systems','2023-01-01',0);

insert into part_tags (tag,ins_date,level) values ('Linux','2023-02-01',1);

insert into part_tags (tag,ins_date,level) values ('BSD Unix','2023-03-01',1);

insert into part_tags (tag,ins_date,level) values ('Rocky Linux Distro','2023-04-01',2);

select * from part_tags;

select * from part_tags_date_01_2023;

select * from part_tags_date_02_2023; 

select * from part_tags_date_03_2023;

select * from part_tags_date_04_2023;

CREATE TABLE part_tags_date_05_2023 PARTITION OF part_tags FOR VALUES FROM ('2023-05-01') TO ('2023-05-30');

\d+ part_tags;

ALTER TABLE part_tags DETACH PARTITION part_tags_date_05_2023 ;

\d+ part_tags;

\d part_tags_already_exists

ALTER TABLE part_tags ATTACH PARTITION part_tags_already_exists FOR VALUES FROM ('1970-01-01') TO ('2022-12-31');

insert into part_tags (tag,ins_date,level) values ('Ubuntu Linux','2023-05-01',2);

CREATE TABLE part_tags_default PARTITION OF part_tags default;

insert into part_tags (tag,ins_date,level) values ('Ubuntu Linux','2023-05-01',2);

select * from part_tags;

select * from part_tags_default ;

create tablespace ts_a location '/data/tablespaces/ts_a';

create tablespace ts_b location '/data/tablespaces/ts_b';

alter tablespace ts_a owner to forum ;

alter tablespace ts_b owner to forum ;

\q

CREATE TABLE tablespace_part_tags (
pk serial NOT NULL,
ins_date date not null default now()::date,
tag VARCHAR (255) NOT NULL,
level INTEGER NOT NULL DEFAULT 0,
primary key (pk,ins_date)
)
PARTITION BY RANGE (ins_date);

CREATE TABLE tablespace_part_tags_date_2022 PARTITION OF tablespace_part_tags FOR VALUES FROM ('2021-01-01') TO ('2022-12-31') TABLESPACE ts_a;

CREATE TABLE tablespace_part_tags_date_2023 PARTITION OF tablespace_part_tags FOR VALUES FROM ('2023-01-01') TO ('2023-12-31') TABLESPACE ts_b;

CREATE TABLE tablespace_part_tags_date_default PARTITION OF tablespace_part_tags default;

insert into tablespace_part_tags (tag,ins_date,level) values ('Operating Systems','2022-01-01',0),  ('Linux','2022-02-01',1),('BSD Unix','2023-03-01',1),('Rocky Linux Distro','2018-04-01',2);

select * from tablespace_part_tags;

select * from tablespace_part_tags_date_2022 ;

select * from tablespace_part_tags_date_2023 ;

select * from tablespace_part_tags_date_default;

select extract (year from insert_time) as year, avg(temperature) avg_temp from basilea group by 1 order by 2  limit 5;

select extract (year from insert_time) as year, avg(temperature) avg_temp from basilea group by 1 order by 2 desc limit 5;

explain analyze select extract (year from insert_time) as year, avg(temperature) avg_temp  from basilea group by 1 order by 2 desc limit 5;

\d+ basilea_partitioned

explain analyze select extract (year from insert_time) as year, avg(temperature) avg_temp  from basilea_partitioned group by 1 order by 2 desc limit 5;

explain analyze select extract (year from insert_time) as year, avg(temperature) avg_temp  from basilea where insert_time >='2021-01-01' and insert_time < '2023-01-01' group by 1 order by 2 desc limit 5;

explain analyze select extract (year from insert_time) as year, avg(temperature) avg_temp  from basilea_partitioned where insert_time >='2021-01-01' and insert_time < '2023-01-01' group by 1 order by 2 desc limit 5;

select * from pg_settings where name ='constraint_exclusion';




























