drop function if exists public.get_playlists;
create or replace function public.get_playlists(
    input_search_term text,
    out output_playlists setof playlists
) as
$$
begin
    return query
        select *
        from playlists
        where playlist_name ilike '%' || input_search_term || '%';
end;
$$ language plpgsql;