create table if not exists users
(
    user_id  uuid primary key default gen_random_uuid(),
    username text not null,
    email    text not null,
    password text not null
);

comment on column users.user_id is 'Unique identifier of the user';
comment on column users.username is 'Users username';
comment on column users.email is 'Users email address';
comment on column users.password is 'Password hash of the user';

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

create table if not exists playlists
(
    playlist_id   uuid primary key default gen_random_uuid(),
    playlist_name text not null
);

comment on column playlists.playlist_id is 'Unique identifier for the playlist';
comment on column playlists.playlist_name is 'Name of the playlist';

create table if not exists artists
(
    artist_id   uuid primary key default gen_random_uuid(),
    artist_name text not null
);

comment on column artists.artist_id is 'Unique identifier of the artist';
comment on column artists.artist_name is 'Artist name';

create table if not exists albums
(
    album_id     uuid primary key default (gen_random_uuid()),
    album_name   text not null,
    album_type   text not null,
    release_year timestamptz,
    genre        text,
    description  text
);

comment on column albums.album_id is 'Unique identifier of the album';
comment on column albums.album_name is 'Album name';
comment on column albums.album_type is 'Album type (single or album)';
comment on column albums.release_year is 'Year of album release';
comment on column albums.genre is 'Genre of the album';
comment on column albums.description is 'Description of the album';

create table if not exists user_playlists
(
    user_id     uuid references users (user_id),
    playlist_id uuid references playlists (playlist_id),
    primary key (user_id, playlist_id)
);

comment on column user_playlists.user_id is 'Reference to the user';
comment on column user_playlists.playlist_id is 'Reference to the playlist';

create table if not exists artist_tracks
(
    artist_id uuid references artists (artist_id),
    track_id  uuid references tracks (track_id),
    primary key (artist_id, track_id)
);

comment on column artist_tracks.artist_id is 'Unique identifier of the artist';
comment on column artist_tracks.track_id is 'Artist name';

create table if not exists artist_albums
(
    artist_id uuid references artists (artist_id),
    album_id  uuid references albums (album_id),
    primary key (artist_id, album_id)
);

comment on column artist_albums.artist_id is 'Reference to the artist';
comment on column artist_albums.album_id is 'Reference to the album';

create table if not exists album_tracks
(
    album_id     uuid references albums (album_id),
    track_id     uuid references tracks (track_id),
    track_number int,
    primary key (album_id, track_id)
);

comment on column album_tracks.album_id is 'Reference to the album';
comment on column album_tracks.track_id is 'Reference to the track';
comment on column album_tracks.track_number is 'Track number in the album';

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
