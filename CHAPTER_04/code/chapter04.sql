\x
\l
\c forumdb
create user myuser with password 'SuperSecret' login;
set role to myuser;
create table mytable(id integer);
create database myforumdb;
\c myforumdb
create user myforum with password 'SuperSecret' login;
create schema myforum authorization myforum;
create table mytable(id integer);
\dt
create table dummytable (dummyfield integer not null primary key);
\dt
create database dummydb;
\c dummydb
\dt
\c template1
drop table dummytable;
drop database dummydb ;
create database forumdb2 template forumdb;
\x
\l+ forumdb
select pg_database_size('forumdb');
select pg_size_pretty(pg_database_size('forumdb'));
select * from pg_database where datname='forumdb';
show data_directory;
CREATE TABLE myusers (
 pk int GENERATED ALWAYS AS IDENTITY
 , username text NOT NULL
 , gecos text
 , email text NOT NULL
 , PRIMARY KEY( pk )
 , UNIQUE ( username )
 );
\d myusers
drop table myusers ;

create table if not exists users (
    pk int GENERATED ALWAYS AS IDENTITY
   ,username text NOT NULL
   ,gecos text
   ,email text NOT NULL
   ,PRIMARY KEY( pk )
   ,UNIQUE ( username )
);

drop table if exists myusers;
create temp table if not exists temp_users  (
    pk int GENERATED ALWAYS AS IDENTITY
   ,username text NOT NULL
   ,gecos text
   ,email text NOT NULL
   ,PRIMARY KEY( pk )
   ,UNIQUE ( username )
);

 begin work;
 create temp table if not exists temp_users_transation (
  pk int GENERATED ALWAYS AS IDENTITY
  ,username text NOT NULL
  ,gecos text
  ,email text NOT NULL
  ,PRIMARY KEY( pk )
  ,UNIQUE ( username )
 ) on commit drop;

\d temp_users_transation
commit work;

create unlogged table if not exists unlogged_users (
    pk int GENERATED ALWAYS AS IDENTITY
   ,username text NOT NULL
   ,gecos text
   ,email text NOT NULL
   ,PRIMARY KEY( pk )
   ,UNIQUE ( username )
);

select oid,relname from pg_class where relname='users';
insert into users (username,gecos,email) values ('myusername','mygecos','myemail');
select * from users;
select pk,username,gecos,email from users;
insert into users (username,gecos,email) values ('scotty','scotty_gecos','scotty_email');
select pk,username,gecos,email from users order by username;
select pk,username,gecos,email from users order by 2;
insert into categories (title,description) values ('C Language', 'Languages'), ('Python Language','Languages');
select * from categories;
select * from categories where description ='Database related discussions';
select * from categories where description = 'Languages' and title='C Language';
select * from categories where description ='Languages' order by title desc;
select * from categories where description ='Languages' order by 2 desc;
insert into categories (title) values ('A new discussion');
select * from categories where description ='';
\pset null NULL
select title,description from categories where description is null;
select * from categories order by description ;
select * from categories order by description NULLS last;
select * from categories order by description NULLS first;
create temp table temp_categories as select * from categories;
select * from temp_categories ;
update temp_categories set title='Linux' where pk = 2;
update temp_categories set title = 'no title' where description = 'Languages';
delete from temp_categories where pk=5;
select * from temp_categories where pk=5;
delete from temp_categories where description is null;
delete from temp_categories ;
select * from temp_categories;
insert into temp_categories select * from categories;
truncate table temp_categories ;
select * from temp_categories;
