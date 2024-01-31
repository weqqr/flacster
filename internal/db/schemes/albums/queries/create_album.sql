drop function if exists public.create_album;
create or replace function public.create_album(
    _album_name text,
    _album_type text,
    _release_year timestamptz,
    _genre text,
    _description text,
    out o_album_id uuid
) as
$$
begin
    insert into albums (album_name,
                        album_type,
                        release_year,
                        genre,
                        description)
    values (_album_name,
            _album_type,
            _release_year,
            _genre,
            _description)
    returning album_id into o_album_id;
end;
$$ language plpgsql;