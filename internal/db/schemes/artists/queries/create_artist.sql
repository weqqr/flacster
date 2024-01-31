drop function if exists public.create_artist;
create or replace function public.create_artist(
    _artist_name text,
    out o_artist_id uuid
) as
$$
begin
    insert into artists (artist_name)
    values (_artist_name)
    returning artist_id into o_artist_id;
end;
$$ language plpgsql;