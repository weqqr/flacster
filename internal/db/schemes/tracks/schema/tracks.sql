drop table if exists tracks cascade;
create table if not exists tracks
(
    track_id   uuid primary key default gen_random_uuid(),
    track_name text not null,
    duration   int  not null,
    file_path  text not null
);

comment on column tracks.track_id is 'Unique identifier for the track';
comment on column tracks.track_name is 'Name of the track';
comment on column tracks.duration is 'Duration of the track in seconds';
comment on column tracks.file_path is 'File path of the track on the server';
