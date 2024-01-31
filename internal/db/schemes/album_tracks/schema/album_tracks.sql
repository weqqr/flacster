drop table if exists album_tracks cascade;
create table album_tracks
(
    album_id     uuid references albums (album_id),
    track_id     uuid references tracks (track_id),
    track_number int,
    primary key (album_id, track_id)
);

comment on column album_tracks.album_id is 'Reference to the album';
comment on column album_tracks.track_id is 'Reference to the track';
comment on column album_tracks.track_number is 'Track number in the album';
