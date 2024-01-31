drop function if exists public.get_user;
create or replace function public.get_track(
    _track_id uuid,
    out o_track_name text,
    out o_duration int,
    out o_file_path text
) as
$$
begin
    select track_name, duration, file_path
    into o_track_name, o_duration, o_file_path
    from tracks
    where track_id = _track_id;
end;
$$ language plpgsql;