drop function if exists public.update_playlist;
create or replace function public.update_playlist(
    input_playlist_id uuid,
    input_playlist_name text
) returns void as
$$
begin
    update playlists
    set playlist_name = coalesce(input_playlist_name, playlist_name)
    where playlist_id = input_playlist_id;
end;
$$ language plpgsql;