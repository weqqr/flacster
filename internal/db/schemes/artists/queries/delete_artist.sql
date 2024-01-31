drop function if exists public.delete_artist;
create or replace function public.delete_artist(
    input_artist_id uuid
) returns void as
$$
begin
    delete from artists where artist_id = input_artist_id;
end;
$$ language plpgsql;