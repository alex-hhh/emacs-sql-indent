# Smart indentation for SQL files inside Emacs

This is an add-on to the SQL mode that allows smart indentation for SQL code,
this works like the indentation for C and C++ code: hitting tab indents the
current line at the correct position.

The actual indentation rules are fully configurable, so they can be adjusted
to your preferences. See [customize-indentation.md](customize-indentation.md)
for how to customize the indentation rules.

To install this package, open the file `sql-indent.el` in Emacs and type

    M-x install-package-from-buffer RET

than add the following to your ~/.emacs.el:

    (require 'sql-indent)
    (add-hook 'sql-mode-hook 'sqlind-setup)
