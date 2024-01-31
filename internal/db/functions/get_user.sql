drop function if exists public.get_user;
create or replace function public.get_user(
    _user_id uuid,
    out o_username text,
    out o_email text
) as
$$
begin
    select username, email
    into o_username, o_email
    from users
    where user_id = _user_id;
end;
$$ language plpgsql;