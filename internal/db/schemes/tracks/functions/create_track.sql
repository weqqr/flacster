drop function if exists public.create_track;
create or replace function public.create_track(
    _track_name text,
    _duration int,
    _file_path text,
    out o_track_id uuid
) as
$$
begin
    insert into tracks (track_name,
                        duration,
                        file_path)
    values (_track_name,
            _duration,
            _file_path)
    returning track_id into o_track_id;
end;
$$ language plpgsql;