drop function if exists public.delete_album;
create or replace function public.delete_album(
    input_album_id uuid
) returns void as
$$
begin
    delete from albums where album_id = input_album_id;
end;
$$ language plpgsql;