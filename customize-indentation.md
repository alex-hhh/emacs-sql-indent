# Customizing the SQL  indentation rules

## Overview

The indentation process happens in two separate phases: first syntactic
information is determined about the line, than the line is indented based on
that syntactic information.  The syntactic parse is not expected to change
often, since it deals with the structure of the SQL code, however, indentation
is a personal preference, and can be easily customized.

Two variables control the way code is indented: `sqlind-basic-offset` and
`sqlind-indentation-offsets-alist`.  To customize these variables, you can set
them up in your init.el file before loading the package.  For example:

    (require 'sql-indent)
    (add-hook 'sql-mode-hook 'sqlind-setup)

    (setq sqlind-basic-offset 4) ; use 4 spaces as the basic indentation block.

    ;; Update indentation rules, select, insert, delete and update keywords
    ;; are aligned with the clause start

    (defvar my-sql-indentation-offsets-alist
      `((select-clause 0)
        (insert-clause 0)
        (delete-clause 0)
        (update-clause 0)
        ,@sqlind-default-indentation-offsets-alist))

    (add-hook 'sql-mode-hook
        (lambda ()
           (setq sqlind-indentation-offsets-alist
               my-sql-indentation-offsets-alist)))

The simplest way to adjust the indentation is to explore the syntactic
information using `sqlind-show-syntax-of-line`.  To use it, move the cursor to
the line you would like to be indented and type:

    M-x sqlind-show-syntax-of-line RET

A message like the one below will be shown in the messages buffer:

    ((select-clause . 743) (statement-continuation . 743))

The first symbol displayed is the syntactic symbol used for indentation, in
this case `select-clause`.  The syntactic symbols are described below,
however, for now, this is the symbol that will need to be updated in
`sqlind-indentation-offsets-alist`.  The number next to it represents the
anchor, or reference position in the buffer where the current statement
starts.  It is useful if you need to write your own indentation functions.

To customize indentation for this type of statement, add an entry in the list,
as shown above, with some information about how it should be indented.  The
list can contain any number of symbols, each defining an adjustment to the
base indentation.  The base indentation is the column of the indentation
anchor point.

For example, to indent keyword in SELECT clauses at the same level as the
keyword itself, use:

    (select-clause 0)

To indent it `sqlind-basic-offset` plus one more space, use:

    (select-clause + 1)

To right-justify the keyword w.r.t the SELECT keyword, use:

    (select-clause sqlind-right-justify-clause)

The default value for `sqlind-indentation-offsets-alist` contains many
examples for indentation setup rules.

## Indentation control items

The following items can be present in the indentation list for each syntax
symbol.  Any number of them can be present, but usually on one will be there:

* a `NUMBER` -- the NUMBER will be added to the indentation offset.

* `+` -- the current indentation offset is incremented by `sqlind-basic-offset'

* `++` -- the current indentation offset is indentation by 2 *
  `sqlind-basic-offset'

* `-` -- the current indentation offset is decremented by
  `sqlind-basic-offset'

* `--` -- the current indentation offset is decremented by 2 *
  `sqlind-basic-offset'

* a `FUNCTION` -- the syntax and current indentation offset is passed to the
  function and its result is used as the new indentation offset.  This can be
  used to further customize indentation.

The following functions are available as part of the package:

* `sqlind-use-anchor-indentation` -- discards the current offset and returns
  the indentation column of the ANCHOR

* `sqlind-use-previous-line-indentation` -- discards the current offset and
  returns the indentation column of the previous line

* `sqlind-lineup-to-anchor` -- discards the current offset and returns the
  column of the anchor point, which may be different than the indentation
  column

* `sqlind-lineup-open-paren-to-anchor` -- if the line starts with an open
  paren, discard the current offset and return the column of the anchor point.

* `sqlind-lineup-close-paren-to-open` -- if the line starts with a close
  paren, discard the current offset and return the column of the corresponding
  open paren.

* `sqlind-adjust-comma` -- if the line starts with a comma, adjust the current
  offset so that the line is indented to the first word character.  For
  example, if added to a 'select-column' syntax indentation rule, it will
  indent as follows:

```sql
select col1
   ,   col2 -- align "col2" to "col1"
from my_table;
```

* `sqlind-adjust-and-or` -- line up AND and OR logic operators with the end of
  the where clause.  This rule needs to be added to the in-select-clause
  syntax, after the `sqlind-lineup-to-clause-end`.  For example, the following
  setup:

```elisp
(defvar my-sql-indentation-offsets-alist
  `((in-select-clause   sqlind-lineup-to-clause-end
                        sqlind-adjust-and-or)
    ,@sqlind-default-indentation-offsets-alist))
```

Will indent SQL like this:

```sql
select *
  from table
 where a = b
   and c = d; -- AND clause sits under the where clause
```

* `sqlind-lineup-into-nested-statement` -- discard the current offset and
  return the column of the first word inside a nested statement.  This rule
  makes sense only for 'nested-statement-continuation' syntax indentation
  rule, it will indent as follows:

```sql
(    a,
     b  -- b is aligned with a
)
```

* `sqlind-indent-comment-start`, `sqlind-indent-comment-continuation` -- used
  to indent comments

The following function contain indentation code specific to various SQL
statements.  Have a look at their doc strings for what they do:

* `sqlind-indent-select-column`

* `sqlind-indent-select-table`

* `sqlind-lineup-to-clause-end`

* `sqlind-right-justify-clause`

* `sqlind-lineup-joins-to-anchor`

## Syntactic symbols

The the SQL parsing code returns a syntax definition (either a symbol or a
list) and an anchor point, which is a buffer position.  The syntax symbols can
be used to define how to indent each line.  The following syntax symbols are
defined for SQL code:

* `(syntax-error MESSAGE START END)` -- this is returned when the parse
  failed.  MESSAGE is an informative message, START and END are buffer
  locations denoting the problematic region.  ANCHOR is undefined for this
  syntax info

* `in-comment` -- line is inside a multi line comment, ANCHOR is the start of
  the comment.

* `comment-start` -- line starts with a comment.  ANCHOR is the start of the
  enclosing block.

* `in-string` -- line is inside a string, ANCHOR denotes the start of the
  string.

* `toplevel` -- line is at toplevel (not inside any programming construct).
  ANCHOR is usually (point-min).

* `(in-block BLOCK-KIND LABEL)` -- line is inside a block construct.
  BLOCK-KIND (a symbol) is the actual block type and can be one of "if",
  "case", "exception", "loop" etc.  If the block is labeled, LABEL contains
  the label.  ANCHOR is the start of the block.

* `(in-begin-block KIND LABEL)` -- line is inside a block started by a begin
  statement.  KIND (a symbol) is "toplevel-block" for a begin at toplevel,
  "defun" for a begin that starts the body of a procedure or function, nil for
  a begin that is none of the previous.  For a "defun", LABEL is the name of
  the procedure or function, for the other block types LABEL contains the
  block label, or the empty string if the block has no label.  ANCHOR is the
  start of the block.

* `(block-start KIND)` -- line begins with a statement that starts a block.
  KIND (a symbol) can be one of "then", "else" or "loop".  ANCHOR is the
  reference point for the block start (the corresponding if, case, etc).

- `(block-end KIND LABEL)` -- the line contains an end statement.  KIND (a
  symbol) is the type of block we are closing, LABEL (a string) is the block
  label (or procedure name for an end defun).

- `declare-statement` -- line is after a declare keyword, but before the
  begin.  ANCHOR is the start of the declare statement.

- `(package NAME)` -- line is inside a package definition.  NAME is the name
  of the package, ANCHOR is the start of the package.

- `(package-body NAME)` -- line is inside a package body.  NAME is the name of
  the package, ANCHOR is the start of the package body.

- `(create-statement WHAT NAME)` -- line is inside a CREATE statement (other
  than create procedure or function).  WHAT is the thing being created, NAME
  is its name.  ANCHOR is the start of the create statement.

- `(defun-start NAME)` -- line is inside a procedure of function definition
  but before the begin block that starts the body.  NAME is the name of the
  procedure/function, ANCHOR is the start of the procedure/function
  definition.

The following SYNTAX-es are for SQL statements.  For all of them ANCHOR points
to the start of a statement itself.

* `labeled-statement-start` -- line is just after a label.

* `statement-continuation` -- line is inside a statement which starts on a
  previous line.

* `nested-statement-open` -- line is just inside an opening bracket, but the
  actual bracket is on a previous line.

* `nested-statement-continuation` -- line is inside an opening bracket, but
  not the first element after the bracket.

The following SYNTAX-es are for statements which are SQL code (DML
statements).  They are pecialisations on the previous statement syntaxes and
for all of them a previous generic statement syntax is present earlier in the
SYNTAX list.  Unless otherwise specified, ANCHOR points to the start of the
clause (select, from, where, etc) in which the current point is.

* `with-clause` -- line is inside a WITH clause, but before the main SELECT
  clause.

* `with-clause-cte` -- line is inside a with clause before a CTE (common table
  expression) declaration

* `with-clause-cte-cont` -- line is inside a with clause before a CTE
  definition

* `case-clause` -- line is on a CASE expression (WHEN or END clauses).  ANCHOR
  is the start of the CASE expression.

* `case-clause-item` -- line is on a CASE expression (THEN and ELSE clauses).
  ANCHOR is the position of the case clause.

* `case-clause-item-cont` -- line is on a CASE expression but not on one of
  the CASE sub-keywords.  ANCHOR points to the case keyword that this line is
  a continuation of.

* `select-clause` -- line is inside a select statement, right before one of
  its clauses (from, where, order by, etc).

* `select-column` -- line is inside the select column section, after a full
  column was defined (and a new column definition is about to start).

* `select-column-continuation` -- line is inside the select column section,
  but in the middle of a column definition.  The defined column starts on a
  previous like.  Note that ANCHOR still points to the start of the select
  statement itself.

* `select-join-condition` -- line is right before or just after the ON clause
  for an INNER, LEFT or RIGHT join.  ANCHOR points to the join statement for
  which the ON is defined.

* `select-table` -- line is inside the from clause, just after a table was
  defined and a new one is about to start.

* `select-table-continuation` -- line is inside the from clause, inside a
  table definition which starts on a previous line. Note that ANCHOR still
  points to the start of the select statement itself.

* `(in-select-clause CLAUSE)` -- line is inside the select CLAUSE, which can
  be "where", "order by", "group by" or "having".  Note that CLAUSE can never
  be "select" and "from", because we have special syntaxes inside those
  clauses.

* `insert-clause` -- line is inside an insert statement, right before one of
  its clauses (values, select).

* `(in-insert-clause CLAUSE)` -- line is inside the insert CLAUSE, which can
  be "insert into" or "values".

* `delete-clause` -- line is inside a delete statement right before one of its
  clauses.

* `(in-delete-clause CLAUSE)` -- line is inside a delete CLAUSE, which can be
  "delete from" or "where".

* `update-clause` -- line is inside an update statement right before one of
  its clauses.

* `(in-update-clause CLAUSE)` -- line is inside an update CLAUSE, which can be
  "update", "set" or "where"
