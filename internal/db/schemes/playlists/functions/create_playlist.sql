drop function if exists public.create_playlist;
create or replace function public.create_playlist(
    input_playlist_name text,
    out output_playlist_id uuid
) as
$$
begin
    insert into playlists (playlist_name)
    values (input_playlist_name)
    returning playlist_id into output_playlist_id;
end;
$$ language plpgsql;