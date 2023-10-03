--
-- Learn PostgreSQL (second edition)
--
-- book authors:
--     Luca Ferrari
--     Enrico Pirozzi
--
-- book publisher: Packt


-- Create and populate the forum database


/**
  * General rules followed in this SQL script:
  *
  * - every surrogated primary key is named 'pk' (as Primary Key);
  * - every table name is plural
  */

-- create the 'forum' user, allow login and set a password
CREATE ROLE forum WITH LOGIN PASSWORD 'LearnPostgreSQL';

-- create a new database
CREATE DATABASE forumdb WITH OWNER forum;

-- now connect to the forum database
-- and execute all the population statements
\c forumdb

SET ROLE TO forum;

CREATE SCHEMA forum AUTHORIZATION forum;

CREATE TABLE users (
    pk int GENERATED ALWAYS AS IDENTITY
    , username text NOT NULL
    , gecos text
    , email text NOT NULL
    , PRIMARY KEY( pk )
    , UNIQUE ( username )
    );


INSERT INTO users( username, gecos, email )
VALUES
( 'fluca1978', 'Luca Ferrari', 'fluca1978@gmail.com' )
, ('sscotty71', 'Enrico Pirozzi', 'sscptty71@gmail.com' );



 /*
  * TODO
  * add some columns to the table to demonstrate the ALTER TABLE
  * for instance add a `member_since` with automatic timestamp default
  * add also a gravatr column?
  */


/**
  * A 'categories' is the main top level element
  * that groups a set of posts.
  * For instance categories can be
  * 'unix', 'database', 'php', 'perl' and so on
  */
CREATE TABLE categories (
    pk int GENERATED ALWAYS AS IDENTITY
    , title text NOT NULL
    , description text
    , PRIMARY KEY ( pk )
    );


INSERT INTO categories( title, description )
    VALUES ( 'Database', 'Database related discussions' )
          ,( 'Unix', 'Unix and Linux discussions' )
          ,( 'Programming Languages', 'All about programming languages' );

/**
  * A post is the actual content within a discussion thread.
  * Every post belongs to an author and a category.
  * If a post is the original top post (OP), it has a NULL 'reply_to',
  * otherwise if a post is a reply to another post it does contain
  * a link to the post it is replying to.
  */
CREATE TABLE posts (
    pk int GENERATED ALWAYS AS IDENTITY
    , title           text
    , content         text
    , author          int NOT NULL
    , category        int NOT NULL
    , reply_to        int
    , created_on      timestamp with time zone DEFAULT current_timestamp
    , last_edited_on  timestamp with time zone DEFAULT current_timestamp
    , editable        boolean default true

    , PRIMARY KEY( pk )
    , FOREIGN KEY( author )   REFERENCES users( pk )
    , FOREIGN KEY( reply_to ) REFERENCES posts( pk )
    , FOREIGN KEY( category ) REFERENCES categories( pk )
    );

 /*
  * TODO
  * CTE & recursive CTE to find out top level post (without any reply)
  * create a view 'thread' to show top level post only and the number of child posts
  * create a trigger that 'frozes' a post after a specific amount of time
  * create a RLS to allow editing of only own posts
  */

/**
  * A tag is a "label" that can be attached to a post
  * to help indexing and searching for specific arguments.
  *
  * A tag can be nested into other tags.
  */
CREATE TABLE tags (
    pk        int GENERATED ALWAYS AS IDENTITY
    , tag     text NOT NULL
    , parent  int

    , PRIMARY KEY( pk )
    , FOREIGN KEY( parent ) REFERENCES tags( pk )
    );

    /*
  TODO
  create a recursive CTE to display a tag hierarchy
  */

CREATE TABLE j_posts_tags (
    tag_pk    int NOT NULL
    , post_pk int NOT NULL

    , FOREIGN KEY( tag_pk )  REFERENCES tags( pk )
    , FOREIGN KEY( post_pk ) REFERENCES posts( pk )
    );

    /*
  TODO
  create a trigger that does not allow to add a tag and its parent to the same post?
  for example having 'database > postgresql > psql' it should not be possible
  to add at the same time 'database' and 'psql' to the same post
  */
