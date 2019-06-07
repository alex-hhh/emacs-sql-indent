select *
  from foo
  left outer join bar
      on foo.k = bar.k;

select *
  from foo
  left
         outer join bar
      on foo.k = bar.k;

select *
  from foo
  left outer                     -- test
  join bar
      on foo.k = bar.k;

select *
  from foo
  right outer join bar
      on foo.k = bar.k;

select *
  from foo
  right                          -- test
         outer join bar
      on foo.k = bar.k;

select *
  from foo
  right outer
  join bar
      on foo.k = bar.k;
