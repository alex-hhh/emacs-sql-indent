# Smart indentation for SQL files inside Emacs

This is an add-on to the SQL mode that allows smart indentation for SQL code,
this works like the indentation for C and C++ code: hitting tab indents the
current line at the correct position.

The actual indentation rules are fully configurable, so they can be adjusted
to your preferences. See [customize-indentation.md](customize-indentation.md)
for how to customize the indentation rules.

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

To use that feature, select the relevant region and type

    M-x align RET
    
# Instalation

To install this package, open the file `sql-indent.el` in Emacs and type

    M-x install-package-from-buffer RET

than add the following to your ~/.emacs.el:

    (require 'sql-indent)
    (add-hook 'sql-mode-hook 'sqlind-setup)
