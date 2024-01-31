drop function if exists public.get_album;
create or replace function public.get_album(
    _album_id uuid,
    out o_album_name text,
    out o_album_type text,
    out o_release_year timestamptz,
    out o_genre text,
    out o_description text
) as
$$
begin
    select album_name, album_type, release_year, genre, description
    into o_album_name, o_album_type, o_release_year, o_genre, o_description
    from albums
    where album_id = _album_id;
end;
$$ language plpgsql;