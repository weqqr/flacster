drop table if exists album_tracks cascade;
create table album_tracks
(
    album_id     uuid references albums (album_id),
    track_id     uuid references tracks (track_id),
    track_number int,
    primary key (album_id, track_id)
);

comment on column album_tracks.album_id IS 'Ссылка на альбом';
comment on column album_tracks.track_id IS 'Ссылка на трек';
comment on column album_tracks.track_number is 'Номер трека в альбоме';