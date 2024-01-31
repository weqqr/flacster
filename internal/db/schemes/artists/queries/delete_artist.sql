drop function if exists public.delete_artist;
create or replace function public.delete_artist(
    _artist_id uuid
) returns void as
$$
begin
    delete from artists where artist_id = _artist_id;
end;
$$ language plpgsql;