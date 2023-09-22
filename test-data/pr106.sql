CREATE FUNCTION iota (count INT)
  RETURNS TABLE (n INT)
BEGIN ATOMIC
  WITH RECURSIVE iota (n) AS (
    SELECT 1 AS n
     UNION ALL
    SELECT n + 1
      FROM iota
     WHERE n < count
  )
  SELECT * FROM iota;
END;

CREATE FUNCTION iota (count INT)
  RETURNS TABLE (n INT)
BEGIN NOT ATOMIC
  WITH RECURSIVE iota (n) AS (
    SELECT 1 AS n
     UNION ALL
    SELECT n + 1
      FROM iota
     WHERE n < count
  )
  SELECT * FROM iota;
END;

CREATE FUNCTION iota (count INT)
  RETURNS TABLE (n INT)
BEGIN
  WITH RECURSIVE iota (n) AS (
    SELECT 1 AS n
     UNION ALL
    SELECT n + 1
      FROM iota
     WHERE n < count
  )
  SELECT * FROM iota;
END;
