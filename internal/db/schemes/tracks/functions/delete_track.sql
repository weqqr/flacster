drop function if exists public.delete_track;
create or replace function public.delete_track(
    input_track_id uuid
) returns void as
$$
begin
    delete from tracks where track_id = input_track_id;
end;
$$ language plpgsql;