-- -*- mode: sql; sql-product: postgres; -*-
create function less_than(a text, b text) returns boolean as $$
  declare
    local_a text := a;
    local_b text := b;
  begin
    return local_a < local_b;
  end;
$$ language plpgsql;

declare
  liahona
  cursor for
  select *
    from films;

create function less_than(a text, b text) returns boolean as $$
  declare
    local_a text := a;
    local_b text := b;
    declare c binary cursor with hold for
      select *
        from films;
  begin
    return local_a < local_b;
  end;
$$ language plpgsql;

-- this line should be toplevel
