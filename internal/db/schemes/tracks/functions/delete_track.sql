drop function if exists public.delete_track;
create or replace function public.delete_track(
    _track_id uuid
) returns void as
$$
begin
    delete from tracks where track_id = _track_id;
end;
$$ language plpgsql;