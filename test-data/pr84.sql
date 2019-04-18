begin;
  select * from foo;
commit;

begin work;
select * from foo;
commit;

begin                                 -- a comment
  work;
select * from foo;
commit;

begin                               -- a comment
  transaction;
select * from foo;
commit;

