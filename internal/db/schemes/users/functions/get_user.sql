drop function if exists public.get_user;
create or replace function public.get_user(
    input_user_id uuid,
    out output_username text,
    out output_email text
) as
$$
begin
    select username, email
    into output_username, output_email
    from users
    where user_id = input_user_id;
end;
$$ language plpgsql;