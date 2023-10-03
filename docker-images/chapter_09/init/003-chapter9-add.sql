\c forumdb

SET ROLE TO forum;
alter table posts drop column likes;
alter table j_posts_tags drop constraint j_posts_tags_pkey;
drop table delete_posts;
insert into tags (tag,parent) values ('Operating Systems',NUll),('Linux',1),('Ubuntu',2);

CREATE TABLE forum.part_tags_already_exists (
    pk integer NOT NULL,
    ins_date date NOT NULL,
    tag character varying(255) NOT NULL,
    level integer NOT NULL
);


ALTER TABLE forum.part_tags_already_exists OWNER TO forum;

--
-- Name: part_tags_already_exists part_tags_already_exists_pkey; Type: CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.part_tags_already_exists
    ADD CONSTRAINT part_tags_already_exists_pkey PRIMARY KEY (pk, ins_date);


--
-- Name: part_tags_already_exists_tag_idx; Type: INDEX; Schema: forum; Owner: forum
--

CREATE INDEX part_tags_already_exists_tag_idx ON forum.part_tags_already_exists USING btree (tag);

