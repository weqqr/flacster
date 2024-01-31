drop function if exists public.get_artists;
create or replace function public.get_artists(
    input_search_term text,
    out output_artists setof artists
) as
$$
begin
    return query
        select *
        from artists
        where artist_name ilike '%' || input_search_term || '%';
end;
$$ language plpgsql;