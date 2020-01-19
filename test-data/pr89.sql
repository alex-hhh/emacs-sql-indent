-- -*- mode: sql; sql-product: postgres; -*-
do $$
  begin
    create table t ();
  end
$$ language plpgsql;

do $$
  begin
    alter table t
      add column c integer;
  end
$$ language plpgsql;

do $$
  begin
    create view t as
      select *
        from foo;
  end
$$ language plpgsql;

do $$
  begin
    create index t on foo(bar);
  end
$$ language plpgsql;

create view t as
  select *
    from foo;
