drop function if exists public.get_artist;
create or replace function public.get_artist(
    input_artist_id uuid,
    out output_artist_name text
) as
$$
begin
    select artist_name
    into output_artist_name
    from artists
    where artist_id = input_artist_id;
end;
$$ language plpgsql;