drop function if exists public.create_album;
create or replace function public.create_album(
    input_album_name text,
    input_album_type text,
    input_release_year timestamptz,
    input_genre text,
    input_description text,
    out output_album_id uuid
) as
$$
begin
    insert into albums (album_name,
                        album_type,
                        release_year,
                        genre,
                        description)
    values (input_album_name,
            input_album_type,
            input_release_year,
            input_genre,
            input_description)
    returning album_id into output_album_id;
end;
$$ language plpgsql;