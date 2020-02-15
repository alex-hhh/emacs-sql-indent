
-- This code illustrates how "where" clauses are indented by chaining
-- `sqlind-lineup-to-clause-end` and `sqlind-right-justify-logical-operator`

delete from foo
 where    a =
          b        -- b is lined up with a
   and c = d       -- the "and" clause is right-aligned under the where clause
   and d = e;

select *
  from foo
 where   a =
         b
   and c = d;

update foo
   set a = 1
 where    a =
          b
   and c = d;
