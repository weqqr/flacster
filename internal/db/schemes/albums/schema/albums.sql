drop table if exists albums cascade;
create table if not exists albums
(
    album_id     uuid primary key default (gen_random_uuid()),
    album_name   text not null,
    album_type   text not null,
    release_year timestamptz,
    genre        text,
    description  text
);

comment on column albums.album_id is 'Уникальный идентификатор альбома';
comment on column albums.album_name is 'Название альбома';
comment on column albums.album_type is 'Тип альбома (сингл или альбом)';
comment on column albums.release_year is 'Год выпуска альбома';
comment on column albums.genre is 'Жанр альбома';
comment on column albums.description is 'Описание альбома';
