# emacs-sql-indent
Smart indentation for SQL files inside Emacs

To use this mode, byte compile this file, than add the following to your
~/.emacs.el:

    (require 'sql-indent)
    (add-hook 'sql-mode-hook 'sqlind-setup)

See [customize-indentation.md](customize-indentation.md) for how to customize
the indentation rules.
