declare
  dummy number;
begin
  begin
    if 1 = 1 then
      proc1;
      proc2;
    else
      proc3;
      proc4;
    end if;
  exception
    when no_data_found then
      proc1;
      proc2;
    when too_many_rows then
      proc3;
      proc4;
    when others then
      proc5;
      end;
end;
/
-- Local Variables:
-- sql-product: oracle
-- End:
