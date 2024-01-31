drop table if exists artists cascade;
create table if not exists artists
(
    artist_id   uuid primary key default gen_random_uuid(),
    artist_name text not null
);

comment on column artists.artist_id is 'Unique identifier of the artist';
comment on column artists.artist_name is 'Artist name';
