-- -*- mode: sql; sql-product: postgres; -*-
create or replace function s.noop()
  returns trigger as $$
  begin
    return new;
  end;
$$ language plpgsql;

create trigger t1
  after insert or update
  on tbl
  for row
    execute procedure s.noop();

create trigger t2
  after insert or update
  on tbl
  for each row
    execute procedure s.noop();

create trigger t3
  after insert or update
  on tbl
  for statement
    execute procedure s.noop();

create trigger t4
  after insert or update
  on tbl
  for each statement
    execute procedure s.noop();
