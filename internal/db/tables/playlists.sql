drop table if exists playlists cascade;
create table if not exists playlists
(
    playlist_id   uuid primary key default gen_random_uuid(),
    playlist_name text not null
);

comment on column playlists.playlist_id is 'Unique identifier for the playlist';
comment on column playlists.playlist_name is 'Name of the playlist';
