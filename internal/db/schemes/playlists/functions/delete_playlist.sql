drop function if exists public.delete_playlist;
create or replace function public.delete_playlist(
    input_playlist_id uuid
) returns void as
$$
begin
    delete from playlists where playlist_id = input_playlist_id;
end;
$$ language plpgsql;