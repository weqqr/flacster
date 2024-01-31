drop function if exists public.update_playlist;
create or replace function public.update_playlist(
    _playlist_id uuid,
    _playlist_name text
) returns void as
$$
begin
    update playlists
    set playlist_name = coalesce(_playlist_name, playlist_name)
    where playlist_id = _playlist_id;
end;
$$ language plpgsql;