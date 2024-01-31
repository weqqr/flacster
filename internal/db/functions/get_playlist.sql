drop function if exists public.get_playlist;
create or replace function public.get_playlist(
    _playlist_id uuid,
    out o_playlist_name text
) as
$$
begin
    select playlist_name
    into o_playlist_name
    from playlists
    where playlist_id = _playlist_id;
end;
$$ language plpgsql;