drop table if exists artist_albums cascade;
create table if not exists artist_albums
(
    artist_id uuid references artists (artist_id),
    album_id  uuid references albums (album_id),
    primary key (artist_id, album_id)
);

comment on column artist_albums.artist_id is 'Reference to the artist';
comment on column artist_albums.album_id is 'Reference to the album';
