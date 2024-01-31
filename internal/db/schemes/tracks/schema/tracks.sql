drop table if exists tracks cascade;
create table if not exists tracks
(
    track_id   uuid primary key default gen_random_uuid(),
    track_name text not null,
    duration   int  not null,
    file_path  text not null
);

comment on column tracks.track_id IS 'Уникальный идентификатор трека';
comment on column tracks.track_name IS 'Название трека';
comment on column tracks.duration IS 'Длительность трека в секундах';
comment on column tracks.file_path IS 'Путь к файлу трека на сервере';
