--chapter 5 sql file
select * from categories where pk > 2;
select * from categories where title like 'Prog%';
select * from categories where title like '%Languages';
select * from categories where description like '%discuss%';
select * from categories where title like 'prog%';
select upper('prog');
select * from categories where upper(description) like '%DISCUSS%';
select * from categories where description ilike '%DISCUSS%';
select coalesce(NULL,'test')
insert into categories (title) values ('New Category');
\pset null (NULL)
select pk,title,description from categories;
select pk,title,coalesce(description,'No description') from categories;
select pk,title,coalesce(description,'No description') as description from categories;
select pk,title,coalesce(description,'No description') as "Description" from categories;
insert into categories (title,description) values ('Database','PostgreSQL');
select title from categories order by title;
select distinct title from categories order by title;
select * from categories order by pk limit 1;
select * from categories order by pk limit 2;
select * from categories order by pk offset 1 limit 1;
create table new_categories as select * from categories limit 0;
select * from categories where pk=1 or pk=2;
select * from categories where pk in (1,2);
select * from categories where not (pk=1 or pk=2);
select * from categories where pk not in (1,2);
insert into users (username,email) values ('luca_ferrari','luca@pgtraining.com'),('enrico_pirozzi','enrico@pgtraiing.com');
insert into posts (title,content,author,category) values ('Indexing PostgreSQL','Btree in PostgreSQL is....',1,1);
insert into posts (title,content,author,category) values ('Indexing Mysql','Btree in Mysql is....',1,1);
insert into posts (title,content,author,category) values ('Data types in C++','Data type in C++ are ..' ,2,3);
\x
select pk,title,content,author,category from posts;
select pk,title,content,author,category from posts where category in (select pk from categories where title ='Database');
\x
select pk from categories where title ='Database';
\x
select pk,title,content,author,category from posts where category not in (select pk from categories where title ='Database');
select pk,title,content,author,category from posts where exists (select 1 from categories where title ='Database' and posts.category=pk);
select pk,title,content,author,category from posts where not exists (select 1 from categories where title ='Database' and posts.category=pk);
select c.pk,c.title,p.pk,p.category,p.title from categories c,posts p;
select c.pk,c.title,p.pk,p.category,p.title from categories c CROSS JOIN posts p;
select c.pk,c.title,p.pk,p.category,p.title from categories c,posts p where c.pk=p.category;
select c.pk,c.title,p.pk,p.category,p.title from categories c inner join posts p on c.pk=p.category;
\x
select c.*,p.category,p.title from categories c left join posts p on c.pk=p.category;
\x
select * from categories c where c.pk not in (select category from posts);
select * from categories c where not exists (select 1 from posts where category=c.pk);
\x
select c.*,p.category from categories c left join posts p on p.category=c.pk;
\x
select c.* from categories c left join posts p on p.category=c.pk where p.category is null;
\x
select c.*,p.category,p.title from posts p right join categories c on c.pk=p.category;
create temp table new_posts as select * from posts;
insert into new_posts (pk,title,content,author,category) values (6,'A new Book','A new book not present in categories....',1,NULL);
select pk,title,category from new_posts ;
select c.pk,c.title,p.pk,p.title from categories c inner join new_posts p on p.category=c.pk;
select c.pk,c.title,p.pk,p.title from categories c full outer join new_posts p on p.category=c.pk;
select c.pk,c.title,p.pk,p.title from categories c cross join new_posts p;
alter table posts add likes integer default 0;
update posts set likes = 3 where title like 'Indexing%';
select title,likes from posts order by likes ;
select u.* from users u where exists (select 1 from posts p where u.pk=p.author and likes > 2 ) ;
select u.username,q.* from users u join lateral (select author, title,likes from posts p where u.pk=p.author and likes > 2 ) as q on true;
select category,count(*) from posts group by category;
select category,count(*) from posts group by 1;
select category,count(*) from posts group by category having count(*) > 1;
select category,count(*) from posts group by 1 having count(*) > 1;
select category,count(*) as category_count from posts group by category;
select category,count(*) as category_count from posts group by category having category_count > 1;
select category,count(*) as category_count from posts group by category having count(*) > 1;
insert into tags (tag) values ('Database'),('Operating Systems');
select tag from tags;
select title from categories;
select tag as datalist from tags UNION select title as datalist from categories;
select tag as datalist from tags UNION ALL select title as datalist from categories order by 1;
select tag from tags;
select title from categories;
select title as datalist from categories except select tag as datalist from tags order by 1;
select title as datalist from categories intersect select tag as datalist from tags order by 1;
\d j_posts_tags
alter table j_posts_tags add constraint j_posts_tags_pkey primary key (tag_pk,post_pk);
\d j_posts_tags
insert into j_posts_tags (post_pk ,tag_pk) values (7,3),(5,3),(6,3);
select * from j_posts_tags ;
insert into j_posts_tags (post_pk ,tag_pk) values (5,3);
insert into j_posts_tags (post_pk ,tag_pk) values (5,3) ON CONFLICT DO NOTHING;
select * from j_posts_tags ;
insert into j_posts_tags (post_pk ,tag_pk) values (5,3) ON CONFLICT (tag_pk,post_pk) DO UPDATE set tag_pk=excluded.tag_pk+1;
select * from j_posts_tags ;
insert into j_posts_tags (tag_pk,post_pk) values(3,5) returning *;
insert into j_posts_tags (tag_pk,post_pk) values(4,6) returning tag_pk;
update posts set title = 'A view of  Data types in C++' where pk = 7;
SELECT * FROM categories;
create temp table t_categories as select * from categories limit 0;
insert into t_categories (pk,title,description) values (4,'Machine Learning','Machine Learning discussions'),(5,'Software engineering','Software engineering discussions');
select * from t_categories ;
update categories c set title=t.title,description=t.description from t_categories t where c.pk=t.pk;
select * from categories ;
create temp table new_data as select * from categories limit 0;
insert into new_data (pk,title,description) values (1,'Database Discussions','Database discussions'),(2,'Unix/Linux discussion','Unix and Linux discussions');
select * from new_data;
merge into categories c
using new_data n on c.pk=n.pk
when matched then
  update set title=n.title,description=n.description
when not matched then
  insert (pk,title,description)
  OVERRIDING SYSTEM VALUE values (n.pk,n.title,n.description);
select * from categories order by 1;
update categories set title='A.I' where pk=4 returning pk,title,description;
delete from t_categories where pk=4 returning pk,title,description;
  with posts_author_1 as
  (select p.* from posts p
  inner join users u on p.author=u.pk
  where username='enrico_pirozzi')
 select pk,title from posts_author_1;
 select pk,title from
 (select p.* from posts p inner join users u on p.author=u.pk where u.username='enrico_pirozzi') posts_author_1;
 with posts_author_1 as materialized
  (select p.* from posts p
  inner join users u on p.author=u.pk
  where username='enrico_pirozzi')
 select pk,title from posts_author_1;
 with posts_author_1 as not materialized
 (select p.* from posts p
 inner join users u on p.author=u.pk
 where username='enrico_pirozzi')
select pk,title from posts_author_1;
create temp table t_posts as select * from posts;
create table delete_posts as select * from posts limit 0;
select pk,title,category from t_posts ;
select pk,title,category from delete_posts ;
with del_posts as (
    delete from t_posts
    where category in (select pk from categories where title ='Database')
returning *)
insert into delete_posts select * from del_posts;
select pk,title,category from delete_posts ;
drop table if exists t_posts;
create temp table t_posts as select * from posts;
create table inserted_posts as select * from posts limit 0;
with ins_posts as ( insert into inserted_posts select * from t_posts returning pk) delete from t_posts where pk in (select pk from ins_posts);
select pk,title,category from t_posts ;
select pk,title,category from inserted_posts ;
insert into tags (tag,parent) values ('PostgreSQL',1);
select * from tags;
WITH RECURSIVE tags_tree AS (
 -- non recursive statment
SELECT tag, pk, 1 AS level
FROM tags WHERE parent IS NULL
UNION
-- recursive statement
SELECT tt.tag|| ' -> ' || ct.tag, ct.pk
, tt.level + 1
FROM tags ct
JOIN tags_tree tt ON tt.pk = ct.parent
)
SELECT level,tag FROM tags_tree
order by level;
