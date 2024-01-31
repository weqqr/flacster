drop function if exists public.create_track;
create or replace function public.create_track(
    input_track_name text,
    input_duration int,
    input_file_path text,
    out output_track_id uuid
) as
$$
begin
    insert into tracks (track_name, duration, file_path)
    values (input_track_name, input_duration, input_file_path)
    returning track_id into output_track_id;
end;
$$ language plpgsql;