create table if not exists "users"
(
    "user_id"       uuid default gen_random_uuid() primary key,
    "username"      text not null,
    "email"         text not null,
    "password_hash" text not null
);

create table if not exists "artists"
(
    "artist_id"   uuid default gen_random_uuid() primary key,
    "artist_name" text not null
);

create table if not exists "albums"
(
    "album_id"   uuid default gen_random_uuid() primary key,
    "artist_id"  uuid,
    "album_name" text not null,
    "album_type" text not null
);

create table if not exists "playlists"
(
    "playlist_id"   uuid default gen_random_uuid() primary key,
    "user_id"       uuid,
    "playlist_name" text not null
);

create table if not exists "tracks"
(
    "track_id"   uuid default gen_random_uuid() primary key,
    "artist_id"  uuid,
    "album_id"   uuid,
    "track_name" text not null,
    "duration"   int  not null,
    "file_path"  text not null
);

create table if not exists "playlist_tracks"
(
    "playlist_id" uuid,
    "track_id"    uuid,
    primary key ("playlist_id", "track_id")
);

create index on "albums" ("artist_id");
create index on "playlists" ("user_id");

create index on "tracks" ("artist_id");
create index on "tracks" ("album_id");

create index on "playlist_tracks" ("playlist_id");
create index on "playlist_tracks" ("track_id");

comment on column "users"."user_id" IS 'Уникальный идентификатор пользователя';
comment on column "users"."username" IS 'Имя пользователя';
comment on column "users"."email" IS 'Электронная почта пользователя';
comment on column "users"."password_hash" IS 'Хеш пароля пользователя';

comment on column "artists"."artist_id" IS 'Уникальный идентификатор артиста';
comment on column "artists"."artist_name" IS 'Имя артиста';

comment on column "albums"."album_id" IS 'Уникальный идентификатор альбома';
comment on column "albums"."artist_id" IS 'Ссылка на артиста';
comment on column "albums"."album_name" IS 'Название альбома';
comment on column "albums"."album_type" IS 'Тип альбома (Сингл или Альбом)';

comment on column "playlists"."playlist_id" IS 'Уникальный идентификатор плейлиста';
comment on column "playlists"."user_id" IS 'Ссылка на пользователя';
comment on column "playlists"."playlist_name" IS 'Название плейлиста';

comment on column "tracks"."track_id" IS 'Уникальный идентификатор трека';
comment on column "tracks"."artist_id" IS 'Ссылка на артиста';
comment on column "tracks"."album_id" IS 'Ссылка на альбом';
comment on column "tracks"."track_name" IS 'Название трека';
comment on column "tracks"."duration" IS 'Длительность трека в секундах';
comment on column "tracks"."file_path" IS 'Путь к файлу трека на сервере';

comment on column "playlist_tracks"."playlist_id" IS 'Ссылка на плейлист';
comment on column "playlist_tracks"."track_id" IS 'Ссылка на трек';

alter table "albums"
    add foreign key ("artist_id") references "artists" ("artist_id");

alter table "playlists"
    add foreign key ("user_id") references "users" ("user_id");

alter table "tracks"
    add foreign key ("artist_id") references "artists" ("artist_id");

alter table "tracks"
    add foreign key ("album_id") references "albums" ("album_id");

alter table "playlist_tracks"
    add foreign key ("playlist_id") references "playlists" ("playlist_id");

alter table "playlist_tracks"
    add foreign key ("track_id") references "tracks" ("track_id");
