drop function if exists public.get_users;
create or replace function public.get_users(
    _search_term text,
    out o_users setof users
) as
$$
begin
    return query
        select *
        from users
        where username ilike '%' || _search_term || '%';
end;
$$ language plpgsql;