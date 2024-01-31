drop table if exists artist_tracks cascade;
create table artist_tracks
(
    artist_id uuid references artists (artist_id),
    track_id  uuid references tracks (track_id),
    primary key (artist_id, track_id)
);

comment on column artist_tracks.artist_id IS 'Ссылка на автора';
comment on column artist_tracks.track_id IS 'Ссылка на трек';