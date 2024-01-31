drop function if exists public.create_artist;
create or replace function public.create_artist(
    input_artist_name text,
    out output_artist_id uuid
) as
$$
begin
    insert into artists (artist_name)
    values (input_artist_name)
    returning artist_id into output_artist_id;
end;
$$ language plpgsql;