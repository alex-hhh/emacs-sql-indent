begin transaction;
create table my_table ( id text );
select id from my_table;
commit;

begin
  transaction;
create table my_table ( id text );
select id from my_table;
commit;

begin -- a comment

  transaction;
create table my_table ( id text );
select id from my_table;
commit;
