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

comment on column albums.album_id is 'Unique identifier of the album';
comment on column albums.album_name is 'Album name';
comment on column albums.album_type is 'Album type (single or album)';
comment on column albums.release_year is 'Year of album release';
comment on column albums.genre is 'Genre of the album';
comment on column albums.description is 'Description of the album';
