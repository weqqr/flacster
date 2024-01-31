drop function if exists public.delete_user;
create or replace function public.delete_user(
    input_user_id uuid
) returns void as
$$
begin
    delete from users where user_id = input_user_id;
end;
$$ language plpgsql;
