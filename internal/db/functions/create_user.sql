drop function if exists public.create_user;
create or replace function public.create_user(
    _username text,
    _email text,
    _password text,
    out o_user_id uuid
) as
$$
begin
    insert into users (username,
                       email,
                       password)
    values (_username,
            _email,
            _password)
    returning user_id into o_user_id;
end;
$$ language plpgsql;