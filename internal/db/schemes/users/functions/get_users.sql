drop function if exists public.get_users;
create or replace function public.get_users(
    input_search_term text,
    out output_users setof users
) as
$$
begin
    return query
        select *
        from users
        where username ilike '%' || input_search_term || '%';
end;
$$ language plpgsql;