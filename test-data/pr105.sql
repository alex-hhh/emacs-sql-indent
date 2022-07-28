-- -*- mode: sql; sql-product: postgres; -*-
create or replace function something_great() returns integer as $$
  <<locals>>
  declare
    group_id       grp.id%TYPE;
    transaction_id integer;
  begin
    return 0;
  end
$$
