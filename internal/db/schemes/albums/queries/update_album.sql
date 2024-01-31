drop function if exists public.update_albums;
create or replace function public.update_albums(
    input_album_id uuid,
    input_album_name text,
    input_album_type text,
    input_release_year timestamptz,
    input_genre text,
    input_description text
) returns void as
$$
begin
    update albums
    set album_name   = coalesce(input_album_name, album_name),
        album_type   = coalesce(input_album_type, album_type),
        release_year = coalesce(input_release_year, release_year),
        genre        = coalesce(input_genre, genre),
        description  = coalesce(input_description, description)
    where album_id = input_album_id;
end;
$$ language plpgsql;
