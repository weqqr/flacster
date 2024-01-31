drop function if exists public.update_artist;
create or replace function public.update_artist(
    _artist_id uuid,
    _artist_name text
) returns void as
$$
begin
    update artists
    set artist_name = coalesce(_artist_name, artist_name)
    where artist_id = _artist_id;
end;
$$ language plpgsql;