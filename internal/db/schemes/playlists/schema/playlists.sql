drop table if exists playlists cascade;
create table if not exists playlists
(
    playlist_id   uuid primary key default gen_random_uuid(),
    playlist_name text not null
);

comment on column playlists.playlist_id is 'Уникальный идентификатор плейлиста';
comment on column playlists.playlist_name is 'Название плейлиста';
