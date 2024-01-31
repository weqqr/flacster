drop function if exists public.get_artists;
create or replace function public.get_artists(
    _search_term text,
    out o_artists setof artists
) as
$$
begin
    return query
        select *
        from artists
        where artist_name ilike '%' || _search_term || '%';
end;
$$ language plpgsql;