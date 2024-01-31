drop function if exists public.update_artist;
create or replace function public.update_artist(
    input_artist_id uuid,
    input_artist_name text
) returns void as
$$
begin
    update artists
    set artist_name = coalesce(input_artist_name, artist_name)
    where artist_id = input_artist_id;
end;
$$ language plpgsql;