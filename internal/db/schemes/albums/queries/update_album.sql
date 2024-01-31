drop function if exists public.update_albums;
create or replace function public.update_albums(
    _album_id uuid,
    _album_name text,
    _album_type text,
    _release_year timestamptz,
    _genre text,
    _description text
) returns void as
$$
begin
    update albums
    set album_name   = coalesce(_album_name, album_name),
        album_type   = coalesce(_album_type, album_type),
        release_year = coalesce(_release_year, release_year),
        genre        = coalesce(_genre, genre),
        description  = coalesce(_description, description)
    where album_id = _album_id;
end;
$$ language plpgsql;
