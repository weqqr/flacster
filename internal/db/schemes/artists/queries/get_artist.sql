drop function if exists public.get_artist;
create or replace function public.get_artist(
    _artist_id uuid,
    out o_artist_name text
) as
$$
begin
    select artist_name
    into o_artist_name
    from artists
    where artist_id = _artist_id;
end;
$$ language plpgsql;