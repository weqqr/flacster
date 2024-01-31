drop function if exists public.get_playlists;
create or replace function public.get_playlists(
    _search_term text,
    out o_playlists setof playlists
) as
$$
begin
    return query
        select *
        from playlists
        where playlist_name ilike '%' || _search_term || '%';
end;
$$ language plpgsql;