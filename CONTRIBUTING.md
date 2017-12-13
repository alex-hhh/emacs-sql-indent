# If you have a question

To ask a question about the package, please please [create an
issue][gh-issue-link] containing a description of what you are trying to do
and consider providing sample SQL code if appropriate.  There is also a
[manual](./sql-indent.org) which provides information about customizing the
indentation rules.


# If you found a bug

If you found a bug in the SQL indentation code, or don't know how to configure
the indentation rules to suit your preferences, please [create an
issue][gh-issue-link].  Please provide a sample SQL code snippet that
demonstrates the problem.


# Submitting code changes

The preferred way to accept contributions is to submit a pull request using
GitHub.  Before doing so, you need to be aware of the copyright assignment
requirements and the automated test-suite.  These are detailed in the sections
below.

## Copyright Assignment

This package is part of [GNU ELPA][elpa-link] and it is subject to the GNU
[Copyright Assignment][copy-papers-link] policy. Any [legally
significant][legally-link] contributions can only be accepted after the author
has completed their paperwork. Please see [the request form][request-link] if
you want to proceed with the assignment.

## Automated test suite

There's an automated test suite which is used to ensure we don't re-introduce
bugs that that were already fixed.  Please run the test suite to test that
your changes did not break anything.  You can load that the
[sql-indent-test.el](./sql-indent-test.el) file, than run them inside Emacs
using the command:

    M-x ert RET "^sqlind-" RET

Tests can also be run in batch mode using the following command:

    emacs -batch -Q --no-site-file -L . -l sql-indent-test.el -f ert-run-tests-batch-and-exit

If you fix the problem with the indentation, please provide an automated test
for the fixes.  The file [sql-indent-test.el](./sql-indent-test.el) contains a
description on how to do that.

The test files are named after the pull request number.  For example, for pull
request #49, the test files are named `pr49.sql` for the sample SQL code and
`pr49-syn.eld` for the syntax symbol files.  This means you will need to
create the pull request first, and once you know the number, add or update the
test file names.  Sorry about that.

## Other considerations for the pull request

In your pull request, please provide a clear description of what the changes
do and add a sample SQL snippet that illustrates the problem being solved.

Once you submit the pull request, an automated build will start and will run
the unit tests, please verify that the build succeeds and fix any issues if
the build failed.


[elpa-link]: http://elpa.gnu.org/packages/
[copy-papers-link]: http://www.gnu.org/prep/maintain/html_node/Copyright-Papers.html
[legally-link]: http://www.gnu.org/prep/maintain/html_node/Legally-Significant.html#Legally-Significant
[request-link]: http://git.savannah.gnu.org/cgit/gnulib.git/tree/doc/Copyright/request-assign.future
[gh-issue-link]: https://github.com/alex-hhh/emacs-sql-indent/issues

