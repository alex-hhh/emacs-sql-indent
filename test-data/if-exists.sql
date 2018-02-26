drop index if exists IX1_SOME_TABLE;

create index IX1_SOME_TABLE
  on SOME_TABLE(some_column);

create index if not exists IX2_SOME_TABLE
  on SOME_TABLE(some_other_column);

create index IX3_SOME_TABLE
  on SOME_TABLE(some_other_column);
