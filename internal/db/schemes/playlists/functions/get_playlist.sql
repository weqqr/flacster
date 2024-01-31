drop function if exists public.get_playlist;
create or replace function public.get_playlist(
    input_playlist_id uuid,
    out output_playlist_name text
) as
$$
begin
    select playlist_name
    into output_playlist_name
    from playlists
    where playlist_id = input_playlist_id;
end;
$$ language plpgsql;