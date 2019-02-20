create or replace
  private temp table mytable as
  select distinct table1.fielda as firstfield,
                  table2.fieldb as secondfield
    from table1
           join table2 on table1.table1id = table2.fktable1;

create materialized view myview as
  select distinct table1.fielda as firstfield,
                  table2.fieldb as secondfield
    from table1
           join table2 on table1.table1id = table2.fktable1;

create private    -- apparently all temporary tables must be private in Oracle
  temporary table if not exists foo
  as
  select distinct table1.fielda as firstfield,
                  table2.fieldb as secondfield
    from table1
           join table2 on table1.table1id = table2.fktable1;

-- local variables:
-- mode: sql
-- sql-product: oracle
-- end:
