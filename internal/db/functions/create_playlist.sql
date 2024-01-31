drop function if exists public.create_playlist;
create or replace function public.create_playlist(
    _playlist_name text,
    out o_playlist_id uuid
) as
$$
begin
    insert into playlists (playlist_name)
    values (_playlist_name)
    returning playlist_id into o_playlist_id;
end;
$$ language plpgsql;