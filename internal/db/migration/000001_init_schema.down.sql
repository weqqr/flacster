drop table if exists users cascade;
drop function if exists public.create_user;
drop function if exists public.delete_user;
drop function if exists public.get_user;
drop function if exists public.get_users;
drop function if exists public.update_user;

drop table if exists tracks cascade;
drop function if exists public.create_track;
drop function if exists public.delete_track;
drop function if exists public.get_track;
drop function if exists public.get_tracks;
drop function if exists public.update_track;

drop table if exists playlists cascade;
drop function if exists public.create_playlist;
drop function if exists public.delete_playlist;
drop function if exists public.get_playlist;
drop function if exists public.get_playlists;
drop function if exists public.update_playlist;

drop table if exists artists cascade;
drop function if exists public.create_artist;
drop function if exists public.delete_artist;
drop function if exists public.get_artist;
drop function if exists public.get_artists;
drop function if exists public.update_artist;

drop table if exists albums cascade;
drop function if exists public.create_album;
drop function if exists public.delete_album;
drop function if exists public.get_album;
drop function if exists public.get_albums;
drop function if exists public.update_album;

drop table if exists user_playlists cascade;

drop table if exists playlist_tracks cascade;

drop table if exists artist_tracks cascade;

drop table if exists artist_albums cascade;

drop table if exists album_tracks cascade;
