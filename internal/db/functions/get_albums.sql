drop function if exists public.get_albums;
create or replace function public.get_albums(
    _search_term text,
    out o_albums setof albums
) as
$$
begin
    return query
        select *
        from albums
        where album_name ilike '%' || _search_term || '%';
end;
$$ language plpgsql;
