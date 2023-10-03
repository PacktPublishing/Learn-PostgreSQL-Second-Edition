create database forumdb;
use forumdb;

CREATE TABLE users (
    pk int AUTO_INCREMENT NOT NULL,
    username varchar(255) NOT NULL,
    gecos text,
    email varchar(255) NOT NULL,
    PRIMARY KEY (pk),
    UNIQUE (username)
);


INSERT INTO users (username, gecos, email)
VALUES
('fluca1978', 'Luca Ferrari', 'fluca1978@gmail.com'),
('sscotty71', 'Enrico Pirozzi', 'sscptty71@gmail.com');


CREATE TABLE categories (
    pk int AUTO_INCREMENT NOT NULL,
    title varchar(255) NOT NULL,
    description text,
    PRIMARY KEY (pk)
);

INSERT INTO categories (title, description)
VALUES ('Database', 'Database related discussions'),
('Unix', 'Unix and Linux discussions'),
('Programming Languages', 'All about programming languages');


CREATE TABLE posts (
    pk int AUTO_INCREMENT NOT NULL
    , title           text
    , content         text
    , author          int NOT NULL
    , category        int NOT NULL
    , reply_to        int
    , created_on      timestamp DEFAULT current_timestamp
    , last_edited_on  timestamp DEFAULT current_timestamp
    , editable        boolean default true
    ,PRIMARY KEY (pk)
    ,FOREIGN KEY (author) REFERENCES users (pk)
    ,FOREIGN KEY (reply_to) REFERENCES posts (pk)
    ,FOREIGN KEY (category) REFERENCES categories (pk)
);


CREATE TABLE tags (
    pk int AUTO_INCREMENT,
    tag text NOT NULL,
    parent int,

    PRIMARY KEY (pk),
    FOREIGN KEY (parent) REFERENCES tags (pk)
);


CREATE TABLE j_posts_tags (
    tag_pk int NOT NULL,
    post_pk int NOT NULL,

    FOREIGN KEY (tag_pk) REFERENCES tags (pk),
    FOREIGN KEY (post_pk) REFERENCES posts (pk)
);









