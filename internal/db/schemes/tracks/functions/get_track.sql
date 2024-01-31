drop function if exists public.get_user;
create or replace function public.get_track(
    input_track_id uuid,
    out output_track_name text,
    out output_duration int,
    out output_file_path text
) as
$$
begin
    select track_name, duration, file_path
    into output_track_name, output_duration, output_file_path
    from tracks
    where track_id = input_track_id;
end;
$$ language plpgsql;