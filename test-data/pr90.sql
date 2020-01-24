-- -*- mode: sql; sql-product: postgres; -*-
comment on function hello is 'returns a greeting.';
comment on procedure world is 'creates a world.';
comment -- this is a comment
  on function hello is 'returns a greeting.';
