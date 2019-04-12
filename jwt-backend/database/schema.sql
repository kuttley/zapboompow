BEGIN TRANSACTION;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  user_id serial NOT NULL,
  email varchar(255) NOT NULL UNIQUE, --Email
  username varchar(30) NOT NULL UNIQUE,     -- Username
  password varchar(32) NOT NULL,      -- Password
  salt varchar(256) NOT NULL,          -- Password Salt
  role varchar(255) NOT NULL default('standard'), 
  CONSTRAINT pk_users_user_id PRIMARY KEY (user_id)

);


CREATE SEQUENCE collection_id_seq START 1;

DROP TABLE IF EXISTS collections;

CREATE TABLE collections
(
    user_id integer,
    collection_id integer NOT NULL DEFAULT nextval('collection_id_seq'::regclass),
    collection_name varchar(255) NOT NULL,
    public_bool varchar(5) DEFAULT 'true' NOT NULL, 
    CONSTRAINT pk_collections_collection_id PRIMARY KEY (collection_id)
);

DROP TABLE IF EXISTS comic;

CREATE TABLE comic
(
    comic_id integer NOT NULL, -- pulled from API 
    CONSTRAINT pk_comic_comic_id PRIMARY KEY (comic_id)
);

DROP TABLE IF EXISTS user_collection;

DROP TABLE IF EXISTS comic_collection;

CREATE TABLE comic_collection (
  comic_id integer NOT NULL,
  collection_id integer NOT NULL,
  CONSTRAINT pk_comic_collection_comic_id_collection_id PRIMARY KEY (comic_id, collection_id)
);


ALTER TABLE comic_collection 
ADD FOREIGN KEY(comic_id)
REFERENCES comic(comic_id);

ALTER TABLE comic_collection 
ADD FOREIGN KEY(collection_id)
REFERENCES collections(collection_id);

ALTER TABLE collections ADD FOREIGN KEY (user_id) REFERENCES users(user_id);


COMMIT TRANSACTION;