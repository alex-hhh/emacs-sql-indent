-- -*- mode: sql; sql-product: postgres; -*-

create function less_than(a text, b text) returns boolean as $$
  declare local_a text := a;
  declare local_b text := b;
  declare
    local_d text := d;
    local_c text := c;
  begin
    return local_a < local_b;
  end;
$$ language plpgsql;

create function less_than(a text, b text) returns boolean as $$
  begin
    declare
      local_a text := a;
      local_b text := b;
    begin
      return local_a < local_b;
    end;
  end;
$$ language plpgsql;

create function less_than(a text, b text) returns boolean as $$
  begin
    if a is null then
      declare
        local_a text: a;
      begin
        return false;
      end;
    else
      declare
        local_a text := a;
        local_b text := b;
      begin
        return local_a < local_b;
      end;
    end if;
  end;
$$ language plpgsql;
