drop function if exists public.get_album;
create or replace function public.get_album(
    input_album_id uuid,
    out output_album_name text,
    out output_album_type text,
    out output_release_year timestamptz,
    out output_genre text,
    out output_description text
) as
$$
begin
    select album_name, album_type, release_year, genre, description
    into output_album_name, output_album_type, output_release_year, output_genre, output_description
    from albums
    where album_id = input_album_id;
end;
$$ language plpgsql;