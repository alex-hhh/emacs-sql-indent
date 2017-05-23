# Syntactic indentation for SQL files inside Emacs

This is an add-on to the SQL mode that allows syntactic indentation for SQL
code: hitting tab indents the current line at the correct position, based on
the SQL code before the point.  This works like the indentation for C and C++
code.

The package also supports aligning sql statements, like this:

```sql
update my_table
   set col1_has_a_long_name = value1,
       col2_is_short        = value2,
       col3_med             = v2,
       c4                   = v5
 where cond1 is not null;

select long_colum as lcol,
       scol       as short_column,
       mcolu      as mcol,
  from my_table;
```

To use that feature, select the region you want to align and type:

    M-x align RET

# Instalation

To install this package, open the file `sql-indent.el` in Emacs and type

    M-x install-package-from-buffer RET

The syntactic indentation of SQL code can be turned ON/OFF at any time by
enabling or disabling `sqlind-minor-mode`:

    M-x sqlind-minor-mode RET

To enable syntactic indentation for each SQL buffer, you can add
`sqlind-minor-mode` to `sql-mode-hook`.  First, bring up the customization
buffer using the command:

    M-x customize-variable RET sql-mode-hook RET
    
Than, click on the "INS" button to add a new entry and put "sqlind-minor-mode"
in the text field.

# Configuration

Everyone likes to indent SQL code differently, so the actual indentation rules
are fully configurable, and they can be adjusted to your preferences. See
[customize-indentation.md](customize-indentation.md) for how this works.
