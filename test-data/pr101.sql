-- -*- mode: sql; sql-product: postgres; -*-

perform
  column_a,
  column_b
   from
     table_1
  where
 column_a = 1
    and column_b = 2

perform foo(t.column)
   from mytable t
  where t.column = 1;
