drop function if exists public.update_track;
create or replace function public.update_track(
    _track_id uuid,
    _track_name text,
    _duration int,
    _file_path text
) returns void as
$$
begin
    update tracks
    set track_name = coalesce(_track_name, track_name),
        duration   = coalesce(_duration, duration),
        file_path  = coalesce(_file_path, file_path)
    where track_id = _track_id;
end;
$$ language plpgsql;