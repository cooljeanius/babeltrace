# getline.m4 serial 27

dnl# Copyright (C) 1998-2003, 2005-2007, 2009-2012 Free Software Foundation
dnl#
dnl# This file is free software; the Free Software Foundation
dnl# gives unlimited permission to copy and/or distribute it,
dnl# with or without modifications, as long as this notice is preserved.

AC_PREREQ([2.59])dnl

dnl# See if there is a working, system-supplied vers. of the getline func.
dnl# We cannot just do AC_REPLACE_FUNCS([getline]) because some systems
dnl# have a function by that name in -linet that does NOT have anything
dnl# to do with the function we need.
AC_DEFUN([gl_FUNC_GETLINE],[
  m4_ifdef([gl_STDIO_H_DEFAULTS],[
    AC_REQUIRE([gl_STDIO_H_DEFAULTS])dnl
  ],[
    HAVE_DECL_GETLINE=1; AC_SUBST([HAVE_DECL_GETLINE])
    REPLACE_GETLINE=0;   AC_SUBST([REPLACE_GETLINE])
  ])dnl

  dnl# Persuade glibc <stdio.h> to declare getline():
  AC_REQUIRE([AC_USE_SYSTEM_EXTENSIONS])dnl

  AC_CHECK_DECLS_ONCE([getline])dnl

  gl_getline_needs_run_time_check=no
  AC_CHECK_FUNC([getline],
                [dnl# Found it in some library. Verify that it works.
                 gl_getline_needs_run_time_check=yes],
                [am_cv_func_working_getline=no])
  if test "x${gl_getline_needs_run_time_check}" = "xyes"; then
    AC_CACHE_CHECK([for working getline function],
    [am_cv_func_working_getline],
    [echo fooNbarN | tr -d '\012' | tr N '\012' > conftest.data
    AC_RUN_IFELSE([AC_LANG_SOURCE([[
#    include <stdio.h>
#    include <stdlib.h>
#    include <string.h>
    int main(void)
    {
      FILE *in = fopen("./conftest.data", "r");
      if (!in) {
        return 1;
      }
      {
        /* Test result for a NULL buffer and a zero size.
         * Based on a test program from Karl Heuer.  */
        char *line = NULL;
        size_t siz = 0;
        int len = getline(&line, &siz, in);
        if (!((len == 4) && line && (strcmp(line, "foo\n") == 0))) {
          return 2;
        }
      }
      {
        /* Test result for a NULL buffer and a non-zero size.
         * This crashes on FreeBSD 8.0. */
        char *line = NULL;
        size_t siz = ((size_t)(~0) / 4);
        if (getline(&line, &siz, in) == -1) {
          return 3;
        }
      }
      return 0;
    }
    ]])],[am_cv_func_working_getline=yes] dnl# The library version works.
    ,[am_cv_func_working_getline=no] dnl# The library version fails.
    , dnl# We are cross compiling. Assume it works on glibc2 systems.
      [AC_EGREP_CPP([Lucky_GNU_user],
         [
#include <features.h>
#ifdef __GNU_LIBRARY__
 #if (__GLIBC__ >= 2) && !defined __UCLIBC__
  Lucky_GNU_user
 #endif /* glibc 2+ */
#endif /* __GNU_LIBRARY__ */
         ],
         [am_cv_func_working_getline="guessing yes"],
         [am_cv_func_working_getline="guessing no"])dnl
      ])dnl
    ])
  fi

  if test "x${ac_cv_have_decl_getline}" = "xno"; then
    HAVE_DECL_GETLINE=0
  fi

  case "${am_cv_func_working_getline}" in
    *no)
      dnl# Set REPLACE_GETLINE always: Even if we have not found the broken
      dnl# getline function among ${LIBS}, it may exist in libinet and the
      dnl# executable may be linked with -linet.
      REPLACE_GETLINE=1
      ;;
  esac
])

# Prerequisites of lib/getline.c (none so far).
AC_DEFUN([gl_PREREQ_GETLINE],[:])dnl
