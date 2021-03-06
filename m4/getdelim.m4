# getdelim.m4 serial 11

dnl# Copyright (C) 2005-2007, 2009-2012 Free Software Foundation, Inc.
dnl#
dnl# This file is free software; the Free Software Foundation
dnl# gives unlimited permission to copy and/or distribute it,
dnl# with or without modifications, as long as this notice is preserved.

AC_PREREQ([2.59])dnl

AC_DEFUN([gl_FUNC_GETDELIM],[
  m4_ifdef([gl_STDIO_H_DEFAULTS],[
    AC_REQUIRE([gl_STDIO_H_DEFAULTS])dnl
  ],[
    HAVE_DECL_GETDELIM=1; AC_SUBST([HAVE_DECL_GETDELIM])
    REPLACE_GETDELIM=0;   AC_SUBST([REPLACE_GETDELIM])
  ])dnl

  dnl# Persuade glibc <stdio.h> to declare getdelim() for us:
  AC_REQUIRE([AC_USE_SYSTEM_EXTENSIONS])dnl

  AC_CHECK_DECLS_ONCE([getdelim])dnl
  AC_CHECK_FUNCS_ONCE([getdelim])dnl

  if test "x${ac_cv_func_getdelim}" = "xyes"; then
    HAVE_GETDELIM=1
    dnl# Found it in some library. Verify that it works:
    AC_CACHE_CHECK([for working getdelim function],
                   [gl_cv_func_working_getdelim],
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
        int len = getdelim(&line, &siz, '\n', in);
        if (!((len == 4) && line && (strcmp(line, "foo\n") == 0))) {
          return 2;
        }
      }
      {
        /* Test result for a NULL buffer and a non-zero size.
         * This crashes on FreeBSD 8.0.  */
        char *line = NULL;
        size_t siz = ((size_t)(~0) / 4);
        if (getdelim(&line, &siz, '\n', in) == -1) {
          return 3;
        }
      }
      return 0;
    }
    ]])],[gl_cv_func_working_getdelim=yes] dnl# The library version works.
    ,[gl_cv_func_working_getdelim=no] dnl# The library version fails.
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
         [gl_cv_func_working_getdelim="guessing yes"],
         [gl_cv_func_working_getdelim="guessing no"])dnl
      ])dnl
    ])
    case "${gl_cv_func_working_getdelim}" in
      *no)
        REPLACE_GETDELIM=1
        ;;
    esac
  else
    HAVE_GETDELIM=0
  fi

  if test "x${ac_cv_have_decl_getdelim}" = "xno"; then
    HAVE_DECL_GETDELIM=0
  fi
])dnl

# Prerequisites of compat/getdelim.c.
AC_DEFUN([gl_PREREQ_GETDELIM],[
  AC_CHECK_FUNCS([flockfile funlockfile])dnl
  AC_CHECK_DECLS([getc_unlocked])dnl
])dnl
