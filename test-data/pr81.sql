IF (SELECT ID
      FROM SomeTable
     WHERE SomeField > 0) IS NULL
THEN
  SET SomeVar = TRUE;
ELSIF
  SET SomeVar = FALSE;
END IF;

IF (SELECT ID
      FROM SomeTable
     WHERE SomeField > 0) IS NULL
THEN
  SET SomeVar = TRUE;
ELSEIF
  SET SomeVar = FALSE;
END IF;
