create DATABASE website;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(500),
    surname VARCHAR(500),
    email VARCHAR(500),
    phone INTEGER,
    profile_picture TEXT,
    password_digest VARCHAR(500),
    permission VARCHAR(500)
);

create table articles (
    id SERIAL PRIMARY KEY,
    hero_image TEXT,
    title VARCHAR(500),
    article TEXT,
    category VARCHAR(500),
    date_published TIMESTAMP,
    user_id INTEGER
);

create table quotes (
    id SERIAL PRIMARY KEY,
    quote TEXT,
    author VARCHAR(500),
    more_detail TEXT,
    date_published TIMESTAMP,
    user_id INTEGER
);

create table counters (
    id SERIAL PRIMARY KEY,
    dead_women INTEGER
);