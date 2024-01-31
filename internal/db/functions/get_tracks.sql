drop function if exists public.get_tracks;
create or replace function public.get_tracks(
    _search_term text,
    out o_tracks setof tracks
) as
$$
begin
    return query
        select *
        from tracks
        where track_name ilike '%' || _search_term || '%';
end;
$$ language plpgsql;