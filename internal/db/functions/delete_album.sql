drop function if exists public.delete_album;
create or replace function public.delete_album(
    _album_id uuid
) returns void as
$$
begin
    delete from albums where album_id = _album_id;
end;
$$ language plpgsql;