;;; sql-indent-left.el --- configuration options to indent sql -*- lexical-binding: t -*-
;;
;; Filename: sql-indent-left.el
;; Description:
;; Author: pierre.techoueyres@free.fr
;; Maintainer: pierre.techoueyres@free.fr
;; Copyright (C) 2017, Pierre Téchoueyres all rights reserved.
;; Created:
;; Version: pierre.techoueyres@free.fr
;; Last-Updated:
;;           By:
;;     Update #: 0
;; URL:
;; Keywords: language sql indentation
;; Compatibility:
;;
;; Features that might be required by this library:
;;
;;   None
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; Set configuration options to indent sql my way.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'sql-indent)

(defun sqlind-adjust-operator-left (_syntax base-indentation)
  "Adjust the indentation for operators in select clauses.

Select columns are lined up to the operands, not the operators.
For example.

    select col1, col2
              || col3 as composed_column,
           col4
        || col5 as composed_column2
    from   my_table
    where  cond1 = 1
    and    cond2 = 2;

This is an indentation adjuster and needs to be added to the
`sqlind-indentation-offsets-alist`"
  (save-excursion
    (back-to-indentation)
    ;; If there are non-word constituents at the beginning if the line,
    ;; consider them an operator and line up the line to the first word of the
    ;; line, not the operator
    (cond ((looking-at "\\W+")
	   (let ((ofs (length (match-string 0))))
	     (forward-line -1)
	     (end-of-line)
	     (sqlind-backward-syntactic-ws)
	     (forward-sexp -1)
	     (- (current-column) ofs)))
	  ('t base-indentation))))

(defun sqlind-adjust-operator-right (_syntax base-indentation)
  "Adjust the indentation for operators in select clauses.

Select columns are lined up to the operands, not the operators.
For example.

  select col1, col2
            || col3 as composed_column,
         col4
      || col5 as composed_column2
    from my_table
   where cond1 = 1
     and cond2 = 2;

This is an indentation adjuster and needs to be added to the
`sqlind-indentation-offsets-alist`"
  (save-excursion
    (back-to-indentation)
    ;; If there are non-word constituents at the beginning if the line,
    ;; consider them an operator and line up the line to the first word of the
    ;; line, not the operator
    (cond ((looking-at "\\W+")
	   (let ((ofs (length (match-string 0))))
	     (forward-line -1)
	     (end-of-line)
	     (sqlind-backward-syntactic-ws)
	     (forward-sexp -1)
	     (- (current-column) ofs)))
	  ((looking-at "\\(?:and\\|or\\|not\\)")
	   (let ((ofs (length (match-string 0))))
	     (+ base-indentation (- 5 ofs))))
	  ('t base-indentation))))

(defun sqlind-lone-semicolon (syntax base-indentation)
  "Indent a lone semicolon with the statement start.  For example:

    select col
    from my_table
    ;

This is an indentation adjuster and needs to be added to the
`sqlind-indentation-offsets-alist`"
  (save-excursion
    (back-to-indentation)
    (if (looking-at ";")
        (sqlind-use-anchor-indentation syntax base-indentation)
      base-indentation)))

(defvar sqlind-indentation-right-offsets-alist
  `((select-column-continuation sqlind-indent-select-column
                                sqlind-adjust-operator-left
                                sqlind-lone-semicolon)
    (in-select-clause sqlind-lineup-to-clause-end
                      sqlind-adjust-operator-right
		      sqlind-lone-semicolon)
    (in-delete-clause sqlind-lineup-to-clause-end
                      sqlind-adjust-operator-right
		      sqlind-lone-semicolon)
    (in-insert-clause sqlind-lineup-to-clause-end
                      sqlind-adjust-operator-right
		      sqlind-lone-semicolon)
    (in-update-clause sqlind-lineup-to-clause-end
                      sqlind-adjust-operator-right
		      sqlind-lone-semicolon)
    ;; mandatory 
    (select-table-continuation sqlind-indent-select-table +
                               sqlind-lone-semicolon)
    ;; rest picked up from the original indentation offsets
    ,@sqlind-default-indentation-offsets-alist))

(defvar sqlind-indentation-left-offsets-alist
  `((select-clause 0)
    (insert-clause 0)
    (delete-clause 0)
    (update-clause 0)
    (case-clause-item-cont 0)
    (package +)
    (package-body +)
    (select-column-continuation sqlind-indent-select-column
                                sqlind-adjust-operator-left
                                sqlind-lone-semicolon)
    (in-select-clause sqlind-lineup-to-clause-end
                      sqlind-adjust-operator-left
                      sqlind-lone-semicolon)
    (in-delete-clause sqlind-lineup-to-clause-end
                      sqlind-adjust-operator-left
                      sqlind-lone-semicolon)
    (in-insert-clause sqlind-lineup-to-clause-end
                      sqlind-adjust-operator-left
                      sqlind-lone-semicolon)
    (in-update-clause sqlind-lineup-to-clause-end
                      sqlind-adjust-operator-left
                      sqlind-lone-semicolon)
    (select-table-continuation sqlind-indent-select-table +
                               sqlind-lone-semicolon)
    ;; rest picked up from the original indentation offsets
    ,@sqlind-default-indentation-offsets-alist))

;; (add-hook 'sql-mode-hook
;;           (lambda ()
;;             (setq sqlind-indentation-offsets-alist sqlind-indentation-left-offsets-alist)))

(provide 'sql-indent-left)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sql-indent-left.el ends here
