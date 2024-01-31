drop table if exists playlist_tracks cascade;
create table if not exists playlist_tracks
(
    playlist_id  uuid references playlists (playlist_id),
    track_id     uuid references tracks (track_id),
    track_number int,
    primary key (playlist_id, track_id)
);

comment on column playlist_tracks.playlist_id is 'Reference to the playlist';
comment on column playlist_tracks.track_id is 'Reference to the track';
comment on column playlist_tracks.track_number is 'Track number in the playlist';
