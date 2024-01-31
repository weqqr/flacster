drop function if exists public.delete_playlist;
create or replace function public.delete_playlist(
    _playlist_id uuid
) returns void as
$$
begin
    delete from playlists where playlist_id = _playlist_id;
end;
$$ language plpgsql;