-- create the 'forum' user, allow login and set a password
CREATE ROLE forum WITH LOGIN PASSWORD 'LearnPostgreSQL';

-- create a new database
CREATE DATABASE forumdb WITH OWNER forum;

-- now connect to the forum database
-- and execute all the population statements
\c forumdb

SET ROLE TO forum;

CREATE SCHEMA forum AUTHORIZATION forum;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: forum; Owner: forum
--

CREATE TABLE forum.categories (
    pk integer NOT NULL,
    title text NOT NULL,
    description text
);


ALTER TABLE forum.categories OWNER TO forum;

--
-- Name: categories_pk_seq; Type: SEQUENCE; Schema: forum; Owner: forum
--

ALTER TABLE forum.categories ALTER COLUMN pk ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME forum.categories_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: delete_posts; Type: TABLE; Schema: forum; Owner: forum
--

CREATE TABLE forum.delete_posts (
    pk integer,
    title text,
    content text,
    author integer,
    category integer,
    reply_to integer,
    created_on timestamp with time zone,
    last_edited_on timestamp with time zone,
    editable boolean,
    likes integer
);


ALTER TABLE forum.delete_posts OWNER TO forum;

--
-- Name: j_posts_tags; Type: TABLE; Schema: forum; Owner: forum
--

CREATE TABLE forum.j_posts_tags (
    tag_pk integer NOT NULL,
    post_pk integer NOT NULL
);


ALTER TABLE forum.j_posts_tags OWNER TO forum;

--
-- Name: new_categories; Type: TABLE; Schema: forum; Owner: forum
--

CREATE TABLE forum.new_categories (
    pk integer,
    title text,
    description text
);


ALTER TABLE forum.new_categories OWNER TO forum;

--
-- Name: posts; Type: TABLE; Schema: forum; Owner: forum
--

CREATE TABLE forum.posts (
    pk integer NOT NULL,
    title text,
    content text,
    author integer NOT NULL,
    category integer NOT NULL,
    reply_to integer,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    last_edited_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    editable boolean DEFAULT true,
    likes integer DEFAULT 0
);


ALTER TABLE forum.posts OWNER TO forum;

--
-- Name: posts_pk_seq; Type: SEQUENCE; Schema: forum; Owner: forum
--

ALTER TABLE forum.posts ALTER COLUMN pk ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME forum.posts_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tags; Type: TABLE; Schema: forum; Owner: forum
--

CREATE TABLE forum.tags (
    pk integer NOT NULL,
    tag text NOT NULL,
    parent integer
);


ALTER TABLE forum.tags OWNER TO forum;

--
-- Name: tags_pk_seq; Type: SEQUENCE; Schema: forum; Owner: forum
--

ALTER TABLE forum.tags ALTER COLUMN pk ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME forum.tags_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: forum; Owner: forum
--

CREATE TABLE forum.users (
    pk integer NOT NULL,
    username text NOT NULL,
    gecos text,
    email text NOT NULL
);


ALTER TABLE forum.users OWNER TO forum;

--
-- Name: users_pk_seq; Type: SEQUENCE; Schema: forum; Owner: forum
--

ALTER TABLE forum.users ALTER COLUMN pk ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME forum.users_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: forum; Owner: forum
--

COPY forum.categories (pk, title, description) FROM stdin;
5	Software engineering	Software engineering discussions
1	Database	Database related discussions
2	Unix	Unix and Linux discussions
3	Programming Languages	All about programming languages
4	A.I	Machine Learning discussions
\.


--
-- Data for Name: delete_posts; Type: TABLE DATA; Schema: forum; Owner: forum
--

COPY forum.delete_posts (pk, title, content, author, category, reply_to, created_on, last_edited_on, editable, likes) FROM stdin;
\.


--
-- Data for Name: j_posts_tags; Type: TABLE DATA; Schema: forum; Owner: forum
--

COPY forum.j_posts_tags (tag_pk, post_pk) FROM stdin;
3	7
3	6
4	5
3	5
4	6
\.


--
-- Data for Name: new_categories; Type: TABLE DATA; Schema: forum; Owner: forum
--

COPY forum.new_categories (pk, title, description) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: forum; Owner: forum
--

COPY forum.posts (pk, title, content, author, category, reply_to, created_on, last_edited_on, editable, likes) FROM stdin;
3	Programming languages	All about programming languages	1	1	\N	2023-01-23 15:21:55.747463+00	2023-01-23 15:21:55.747463+00	t	3
5	Indexing PostgreSQL	Btree in PostgreSQL is....	1	1	\N	2023-01-23 15:21:55.747463+00	2023-01-23 15:21:55.747463+00	t	3
6	Indexing Mysql	Btree in Mysql is....	1	1	\N	2023-01-23 15:22:02.38953+00	2023-01-23 15:22:02.38953+00	t	3
7	A view of  Data types in C++	Data type in C++ are	2	3	\N	2023-01-23 15:26:21.367814+00	2023-01-23 15:26:21.367814+00	t	0
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: forum; Owner: forum
--


COPY forum.tags (pk, tag, parent) FROM stdin;
1	Operating Systems	\N
2	Linux	1
3	Ubuntu	2
4	Kubuntu	3
5	Database	\N
6	Operating Systems	\N
\.



--
-- Data for Name: users; Type: TABLE DATA; Schema: forum; Owner: forum
--

COPY forum.users (pk, username, gecos, email) FROM stdin;
1	luca_ferrari	\N	luca@pgtraining.com
2	enrico_pirozzi	\N	enrico@pgtraiing.com
3	newuser	\N	newuser@pgtraining.com
\.


--
-- Name: categories_pk_seq; Type: SEQUENCE SET; Schema: forum; Owner: forum
--

SELECT pg_catalog.setval('forum.categories_pk_seq', 5, true);


--
-- Name: posts_pk_seq; Type: SEQUENCE SET; Schema: forum; Owner: forum
--

SELECT pg_catalog.setval('forum.posts_pk_seq', 8, true);


--
-- Name: tags_pk_seq; Type: SEQUENCE SET; Schema: forum; Owner: forum
--

SELECT pg_catalog.setval('forum.tags_pk_seq', 4, true);


--
-- Name: users_pk_seq; Type: SEQUENCE SET; Schema: forum; Owner: forum
--

SELECT pg_catalog.setval('forum.users_pk_seq', 4, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (pk);


--
-- Name: j_posts_tags j_posts_tags_pkey; Type: CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.j_posts_tags
    ADD CONSTRAINT j_posts_tags_pkey PRIMARY KEY (tag_pk, post_pk);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (pk);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (pk);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (pk);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: j_posts_tags j_posts_tags_post_pk_fkey; Type: FK CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.j_posts_tags
    ADD CONSTRAINT j_posts_tags_post_pk_fkey FOREIGN KEY (post_pk) REFERENCES forum.posts(pk);


--
-- Name: j_posts_tags j_posts_tags_tag_pk_fkey; Type: FK CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.j_posts_tags
    ADD CONSTRAINT j_posts_tags_tag_pk_fkey FOREIGN KEY (tag_pk) REFERENCES forum.tags(pk);


--
-- Name: posts posts_author_fkey; Type: FK CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.posts
    ADD CONSTRAINT posts_author_fkey FOREIGN KEY (author) REFERENCES forum.users(pk);


--
-- Name: posts posts_category_fkey; Type: FK CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.posts
    ADD CONSTRAINT posts_category_fkey FOREIGN KEY (category) REFERENCES forum.categories(pk);


--
-- Name: posts posts_reply_to_fkey; Type: FK CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.posts
    ADD CONSTRAINT posts_reply_to_fkey FOREIGN KEY (reply_to) REFERENCES forum.posts(pk);


--
-- Name: tags tags_parent_fkey; Type: FK CONSTRAINT; Schema: forum; Owner: forum
--

ALTER TABLE ONLY forum.tags
    ADD CONSTRAINT tags_parent_fkey FOREIGN KEY (parent) REFERENCES forum.tags(pk);


--
-- PostgreSQL database dump complete
--

