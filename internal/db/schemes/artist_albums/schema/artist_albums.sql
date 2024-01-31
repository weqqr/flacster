drop table if exists artist_albums cascade;
create table artist_albums
(
    artist_id uuid references artists (artist_id),
    album_id  uuid references albums (album_id),
    primary key (artist_id, album_id)
);

comment on column artist_albums.artist_id is 'Ссылка на артиста';
comment on column artist_albums.album_id is 'Ссылка на альбом';
