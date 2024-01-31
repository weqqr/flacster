drop function if exists public.update_track;
create or replace function public.update_track(
    input_track_id uuid,
    input_track_name text,
    input_duration int,
    input_file_path text
) returns void as
$$
begin
    update tracks
    set track_name = coalesce(input_track_name, track_name),
        duration = coalesce(input_duration, duration),
        file_path = coalesce(input_file_path, file_path)
    where track_id = input_track_id;
end;
$$ language plpgsql;