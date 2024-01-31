drop table if exists user_playlists cascade;
create table if not exists user_playlists
(
    user_id     uuid references users (user_id),
    playlist_id uuid references playlists (playlist_id),
    primary key (user_id, playlist_id)
);

comment on column user_playlists.user_id is 'Ссылка на пользователя';
comment on column user_playlists.playlist_id is 'Ссылка на плейлист';
