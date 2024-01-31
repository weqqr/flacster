drop function if exists public.get_albums;
create or replace function public.get_albums(
    input_search_term text,
    out output_albums setof albums
) as
$$
begin
    return query
        select *
        from albums
        where album_name ilike '%' || input_search_term || '%';
end;
$$ language plpgsql;
