drop table if exists users cascade;
create table if not exists users
(
    user_id  uuid primary key default gen_random_uuid(),
    username text not null,
    email    text not null,
    password text not null
);

comment on column users.user_id is 'Unique identifier of the user';
comment on column users.username is 'Users username';
comment on column users.email is 'Users email address';
comment on column users.password is 'Password hash of the user';
