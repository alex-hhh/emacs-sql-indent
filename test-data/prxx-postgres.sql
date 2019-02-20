create or replace
  global temp table mytable as
  select distinct table1.fielda as firstfield,
                  table2.fieldb as secondfield
    from table1
           join table2 on table1.table1id = table2.fktable1;

create local temporary unlogged table mytable as
  select distinct table1.fielda as firstfield,
                  table2.fieldb as secondfield
    from table1
           join table2 on table1.table1id = table2.fktable1;

create materialized view myview as
  select distinct table1.fielda as firstfield,
                  table2.fieldb as secondfield
    from table1
           join table2 on table1.table1id = table2.fktable1;

create temporary table if not exists foo
  as
  select distinct table1.fielda as firstfield,
                  table2.fieldb as secondfield
    from table1
           join table2 on table1.table1id = table2.fktable1;

-- local variables:
-- mode: sql
-- sql-product: postgres
-- end:
