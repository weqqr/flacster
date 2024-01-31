drop table if exists users cascade;
create table if not exists users
(
    user_id  uuid primary key default gen_random_uuid(),
    username text not null,
    email    text not null,
    password text not null
);

comment on column users.user_id is 'Уникальный идентификатор пользователя';
comment on column users.username is 'Имя пользователя';
comment on column users.email is 'Электронная почта пользователя';
comment on column users.password is 'Хеш пароля пользователя';
