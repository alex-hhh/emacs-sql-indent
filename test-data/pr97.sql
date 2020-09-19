-- -*- mode: sql; sql-product: postgres; -*-

CREATE EXTENSION "uuid-ossp" WITH SCHEMA public;

-- indentation is correct here

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public
  -- invalid syntax, but this treated as a block
END;

-- indentation is correct here

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
-- autoindents to this level

