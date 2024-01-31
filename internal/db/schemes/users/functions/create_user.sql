drop function if exists public.create_user;
create or replace function public.create_user(
    input_username text,
    input_email text,
    input_password text,
    out output_user_id uuid
) as
$$
begin
    insert into users (username, email, password)
    values (input_username, input_email, input_password)
    returning user_id into output_user_id;
end;
$$ language plpgsql;