drop function if exists public.update_user;
create or replace function public.update_user(
    input_user_id uuid,
    input_username text,
    input_email text,
    input_password text
) returns void as
$$
begin
    update users
    set username = coalesce(input_username, username),
        email    = coalesce(input_email, email),
        password = coalesce(input_password, password)
    where user_id = input_user_id;
end;
$$ language plpgsql;