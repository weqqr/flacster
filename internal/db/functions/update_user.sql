drop function if exists public.update_user;
create or replace function public.update_user(
    _user_id uuid,
    _username text,
    _email text,
    _password text
) returns void as
$$
begin
    update users
    set username = coalesce(_username, username),
        email    = coalesce(_email, email),
        password = coalesce(_password, password)
    where user_id = _user_id;
end;
$$ language plpgsql;