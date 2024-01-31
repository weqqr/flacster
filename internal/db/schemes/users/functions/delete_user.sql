drop function if exists public.delete_user;
create or replace function public.delete_user(
    _user_id uuid
) returns void as
$$
begin
    delete from users where user_id = _user_id;
end;
$$ language plpgsql;
