select *
  from foo
         full join bar
             on foo.k = bar.k;

select id
  from foo
except
select id
  from bar;

select id
  from foo
 union
select id
  from bar;

select id
  from foo
 union all
select id
  from bar;

select id
  from foo
 minus
select id
  from bar;

select id
  from foo
intersect
select id
  from bar;
