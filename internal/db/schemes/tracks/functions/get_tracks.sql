drop function if exists public.get_tracks;
create or replace function public.get_tracks(
    input_search_term text,
    out output_tracks setof tracks
) as
$$
begin
    return query
        select *
        from tracks
        where track_name ilike '%' || input_search_term || '%';
end;
$$ language plpgsql;