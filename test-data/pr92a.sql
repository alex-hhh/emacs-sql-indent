-- -*- mode: sql; sql-product: oracle; -*-

cursor foo is
  select *
    from films;

cursor foo int is
  select *
    from films;
