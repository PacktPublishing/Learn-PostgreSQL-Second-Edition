\c forumdb

SET ROLE TO forum;
alter table posts drop column likes;
alter table j_posts_tags drop constraint j_posts_tags_pkey;
drop table delete_posts;
insert into tags (tag,parent) values ('Operating Systems',NUll),('Linux',1),('Ubuntu',2);
