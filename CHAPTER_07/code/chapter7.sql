---Chapter 7

select * from categories where upper(title) like 'A%';

select * from users;

alter table users add user_on_line boolean;

update users set user_on_line = true where pk=1;

\x

select * from users where user_on_line = true;

select * from users where user_on_line is NULL;

\x

select 1.123456789::integer as my_field;

select 1.123456789::int4 as my_field;

select 1.123456789::bigint as my_field;
select 1.123456789::int8 as my_field;

select 1.123456789::real as my_field;

select 1.123456789::double precision as my_field;

select 1.123456789::numeric(10,1) as my_field;

select 1.123456789::numeric(10,5) as my_field;

select 1.123456789::numeric(10,9) as my_field;

select 1.123456789::numeric(10,11) as my_field;

select 1.123456789::numeric(10,10) as my_field;

select 0.123456789::numeric(10,10) as my_field;

create table new_tags ( pk integer not null primary key, tag char(10));

insert into new_tags values (1,'first tag');

insert into new_tags values (2,'tag');

\x

select pk,tag,length(tag),octet_length(tag),char_length(tag) from tags;

drop table if exists new_tags;

create table new_tags (pk integer not null primary key,tag varchar(10));

insert into new_tags values (1,'first tag');

insert into new_tags values (2,'tag');

\x

select pk,tag,length(tag),octet_length(tag) from new_tags ;

insert into new_tags values (3,'this sentence has more than 10 characters');

drop table if exists new_tags;

create table new_tags (pk integer not null primary key,tag text);

insert into new_tags values (1,'first tag'), (2,'tag'),(3,'this sentence has more than 10 characters');

select pk,substring(tag from 0 for 20),length(tag),octet_length(tag) from new_tags ;

\x

select * from pg_settings where name ='DateStyle';

\x

select '12-31-2020'::date;

select to_date('31/12/2020','dd/mm/yyyy') ;

select pk,title,created_on from posts;

select pk,title,to_char(created_on,'dd-mm-yyyy') as created_on from posts;

create table new_posts as select pk,title,created_on::timestamp with time zone as created_on_t, created_on::timestamp without time zone as create_on_nt from posts; 

\d new_posts;

select * from new_posts ;

show timezone;

set timezone='GMT';

select * from new_posts ;

create extension hstore ;

select p.pk,p.title,u.username,c.title as category from posts p  
  inner join users u on p.author=u.pk 
  left join categories c on p.category=c.pk 
  order by 1;

select p.pk,p.title,hstore(ARRAY['username',u.username,'category',c.title]) as options
  from posts p 
  inner join users u on p.author=u.pk 
  left join categories c on p.category=c.pk 
  order by 1;

create table posts_options as 
select p.pk,p.title,hstore(ARRAY['username',u.username,'category',c.title]) as options
from posts p 
inner join users u on p.author=u.pk 
left join categories c on p.category=c.pk 
order by 1;

select * from posts_options where options->'category' ='Database';

insert into posts_options (pk,title,options) values (7,'my last post','"enabled"=>"false"') ;

select * from posts_options;

\x

select p.pk,p.title,t.tag 
  from posts p 
  left join j_posts_tags jpt on p.pk=jpt.post_pk 
  left join tags t on jpt.tag_pk=t.pk
  order by 1;

\x

 select p.pk,p.title,string_agg(t.tag,',') as tag 
  from posts p 
  left join j_posts_tags jpt on p.pk=jpt.post_pk 
  left join tags t on jpt.tag_pk=t.pk 
  group by 1,2 
  order by 1;

select row_to_json(q) as json_data from (
  select p.pk,p.title,string_agg(t.tag,',') as tag 
  from posts p 
  left join j_posts_tags jpt on p.pk=jpt.post_pk 
  left join tags t on jpt.tag_pk=t.pk 
  group by 1,2 order by 1) Q;

create table post_json (jsondata jsonb);

insert into post_json(jsondata)

select row_to_json(q) as json_data from (
  select p.pk,p.title,string_agg(t.tag,',') as tag 
  from posts p 
  left join j_posts_tags jpt on p.pk=jpt.post_pk 
  left join tags t on jpt.tag_pk=t.pk 
group by 1,2 order by 1) Q;

CREATE OR REPLACE FUNCTION my_sum(x integer, y integer) RETURNS integer AS $$
 SELECT x + y;
$$ LANGUAGE SQL;
select my_sum(1,2);

CREATE OR REPLACE FUNCTION delete_posts(p_title text) returns setof integer as $$ 
delete from posts where title=p_title returning pk; 
$$
LANGUAGE SQL;

select pk,title from posts order by pk;

delete from j_posts_tags where post_pk = 7;

select delete_posts('A view of  Data types in C++');

select pk,title from posts order by pk;

create or replace function delete_posts_table (p_title text) 
returns table (ret_key integer,ret_title text) AS 
$$
  delete from posts where title=p_title returning pk,title;
$$
language SQL;

select pk,title from posts order by pk;

insert into posts(title,author,category) values ('My new post',1,1);

select * from  delete_posts_table('My new post');

select pk,title from posts order by pk;

create or replace function nvl ( anyelement,anyelement) returns anyelement as $$
  select coalesce($1,$2);
$$
language SQL;

select nvl(NULL::int,1);

select nvl(''::text,'n'::text);

select nvl('a'::text,'n'::text);

CREATE OR REPLACE FUNCTION my_sum(x integer, y integer) RETURNS integer AS
$BODY$
DECLARE
 ret integer;
BEGIN
 ret := x + y;
 return ret;
END;
$BODY$
language 'plpgsql';

select my_sum(2,3); 

DROP FUNCTION my_sum(integer,integer);

CREATE OR REPLACE FUNCTION my_sum(integer, integer) RETURNS integer AS
$BODY$
DECLARE 
 x alias for $1;
 y alias for $2;
 ret integer;
BEGIN
 ret := x + y;
 return ret;
END;
$BODY$ 
language 'plpgsql';

CREATE OR REPLACE FUNCTION my_sum(integer, integer) RETURNS integer AS 
$BODY$
DECLARE 
 ret integer;
BEGIN
 ret := $1 + $2;
 return ret;
END;
$BODY$ 
language 'plpgsql';

CREATE OR REPLACE FUNCTION my_sum_3_params(IN x integer,IN y integer, OUT z integer) AS 
$BODY$
BEGIN
 z := x+y;
END;
$BODY$ 
language 'plpgsql';

CREATE OR REPLACE FUNCTION my_sum_mul(IN x integer,IN y integer,OUT w integer, OUT z integer) AS 
$BODY$
BEGIN
 z := x+y;
 w := x*y;
END;
$BODY$ 
language 'plpgsql';

select my_sum_mul(2,3);

select * from my_sum_mul(2,3);

select * from my_sum_mul(2,3) where w=6; 

begin ;

select now();

select now();

commit;

begin;

select now();

commit;

begin;

select now();

select lower('MICKY MOUSE');

COMMIT

BEGIN

select now();

select lower('MICKY MOUSE');

commit;

CREATE OR REPLACE FUNCTION my_check(x integer default 0, y integer default 0) RETURNS text AS
$BODY$
BEGIN
 IF x > y THEN
 return 'first parameter is higher than second parameter';
 ELSIF x < y THEN
 return 'second paramater is higher than first parameter';
 ELSE
 return 'the 2 parameters are equals'; 
 END IF;
END;
$BODY$
language 'plpgsql';

select my_check(1,2);

select my_check(2,1);

select my_check(1,1);

CREATE OR REPLACE FUNCTION my_check_value(x integer default 0) RETURNS text AS
$BODY$
BEGIN
 CASE x 
 WHEN 1 THEN return 'value = 1';
 WHEN 2 THEN return 'value = 2';
 ELSE return 'value >= 3 '; 
 END CASE;
END;
$BODY$
language 'plpgsql';

select my_check_value(1);

select my_check_value(2);

select my_check_value(3);

CREATE OR REPLACE FUNCTION my_check_case(x integer default 0, y integer default 0) RETURNS text AS
 $BODY$
 BEGIN
   CASE
    WHEN x > y THEN return 'first parameter is higher than second parameter';
    WHEN x < y THEN return 'second paramater is higher than first parameter';
 ELSE return 'the 2 parameters are equals';
 END CASE;
 END;
 $BODY$
 language 'plpgsql';

select my_check_case(2,1);

select my_check_case(1,2);

select my_check_case(1,1);

select my_check_case();

 create type my_ret_type as ( 
 id integer,
 title text,
 record_data hstore
);

CREATE OR REPLACE FUNCTION my_first_fun (p_id integer) returns setof my_ret_type as
$$
DECLARE
 rw posts%ROWTYPE; -- declare a rowtype;
 ret my_ret_type;
BEGIN
    for rw in select * from posts where pk=p_id loop
      ret.id := rw.pk;
      ret.title := rw.title;
      ret.record_data := hstore(ARRAY['title',rw.title,'Title and Content'
                         ,format('%s %s',rw.title,rw.content)]);
     return next ret;
     end loop;
 return;
END;
$$
language 'plpgsql';

CREATE OR REPLACE FUNCTION my_second_fun (p_id integer) returns setof my_ret_type as
$$
DECLARE
   rw record; -- declare a record variable
   ret my_ret_type;
BEGIN
   for rw in select * from posts where pk=p_id loop
   ret.id := rw.pk;
   ret.title := rw.title;
   ret.record_data := hstore(ARRAY['title',rw.title
                    ,'Title and Content',format('%s %s',rw.title,rw.content)]);
   return next ret;
 end loop;
 return;
END;
$$
language 'plpgsql';

\x

select * from my_first_fun(5);

 CREATE OR REPLACE FUNCTION my_first_except (x real, y real ) returns real as 
$$
DECLARE
 ret real;
BEGIN
 ret := x / y;
 return ret;
END;
$$
language 'plpgsql';

\x

select my_first_except(4,2);

select my_first_except(4,0);

CREATE OR REPLACE FUNCTION my_second_except (x real, y real ) returns real as 
$$
DECLARE
  ret real;
BEGIN
  ret := x / y;
  return ret;
EXCEPTION
  WHEN division_by_zero THEN 
     RAISE INFO 'DIVISION BY ZERO';
     RAISE INFO 'Error % %', SQLSTATE, SQLERRM;
     RETURN 0;
END;
$$
language 'plpgsql' ;

select my_second_except(4,0);

select pid,query from pg_stat_activity  ;

create function forum.my_stat_activity() 
returns table (pid integer,query text) 
as $$ 
	select pid, query  from pg_stat_activity;
$$ language 'sql' 
security definer;


grant execute on function forum.my_stat_activity TO forum;

select * from my_stat_activity();