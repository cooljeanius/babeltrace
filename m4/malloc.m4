# malloc.m4 serial 15
dnl# Copyright (C) 2007, 2009-2012 Free Software Foundation, Inc.
dnl# This file is free software; the Free Software Foundation
dnl# gives unlimited permission to copy and/or distribute it,
dnl# with or without modifications, as long as this notice is preserved.

m4_version_prereq([2.70],[],[

# This is taken from the following Autoconf patch:
# http://git.savannah.gnu.org/gitweb/?p=autoconf.git;a=commitdiff;h=7fbb553727ed7e0e689a17594b58559ecf3ea6e9
AC_DEFUN([_AC_FUNC_MALLOC_IF],[
  AC_REQUIRE([AC_HEADER_STDC])dnl
  AC_REQUIRE([AC_CANONICAL_HOST])dnl# for cross-compiles
  AC_CHECK_HEADERS([stdlib.h])
  AC_CACHE_CHECK([for GNU libc compatible malloc],
    [ac_cv_func_malloc_0_nonnull],
    [AC_RUN_IFELSE(
       [AC_LANG_PROGRAM(
          [[#if defined STDC_HEADERS || defined HAVE_STDLIB_H
            # include <stdlib.h>
            #else
            char *malloc();
            #endif /* STDC_HEADERS || HAVE_STDLIB_H */
          ]],
          [[return ! malloc(0);]])
       ],
       [ac_cv_func_malloc_0_nonnull=yes],
       [ac_cv_func_malloc_0_nonnull=no],
       [case "${host_os}" in
          # Guess yes on platforms where we know the result.
          *-gnu* | freebsd* | netbsd* | openbsd* \
          | hpux* | solaris* | cygwin* | mingw*)
            ac_cv_func_malloc_0_nonnull=yes ;;
          # If we do NOT know, then assume the worst.
          *) ac_cv_func_malloc_0_nonnull=no ;;
        esac
       ])
    ])
  AS_IF([test "x${ac_cv_func_malloc_0_nonnull}" = "xyes"],[$1],[$2])
])# _AC_FUNC_MALLOC_IF

])dnl

# gl_FUNC_MALLOC_GNU
# ------------------
# Test whether 'malloc(0)' is handled like in GNU libc, & replace malloc if
# it is not.
AC_DEFUN([gl_FUNC_MALLOC_GNU],[
  m4_ifdef([gl_STDLIB_H_DEFAULTS],[
    AC_REQUIRE([gl_STDLIB_H_DEFAULTS])dnl
  ],[
    if test "x${REPLACE_MALLOC}" = "x"; then
      test -z "${REPLACE_MALLOC}" && export REPLACE_MALLOC=0; AC_SUBST([REPLACE_MALLOC])
    fi
  ])dnl

  dnl# _AC_FUNC_MALLOC_IF is defined in Autoconf, and above.
  _AC_FUNC_MALLOC_IF(
    [AC_DEFINE([HAVE_MALLOC_GNU],[1],
               [Define to 1 if your system has a glibc-compatible 'malloc'
                function, and to 0 otherwise.])],
    [AC_DEFINE([HAVE_MALLOC_GNU],[0])
     REPLACE_MALLOC=1
    ])dnl
])dnl

# gl_FUNC_MALLOC_POSIX
# --------------------
# Test whether 'malloc' is POSIX compliant (sets errno to ENOMEM when it
# fails), and replace malloc if it is not.
AC_DEFUN([gl_FUNC_MALLOC_POSIX],[
  m4_ifdef([gl_STDLIB_H_DEFAULTS],[
    AC_REQUIRE([gl_STDLIB_H_DEFAULTS])dnl
  ],[
    if test "x${REPLACE_MALLOC}" = "x"; then
      test -z "${REPLACE_MALLOC}" && export REPLACE_MALLOC=0; AC_SUBST([REPLACE_MALLOC])
    fi
  ])dnl

  AC_REQUIRE([gl_CHECK_MALLOC_POSIX])dnl

  if test "x${gl_cv_func_malloc_posix}" = "xyes"; then
    AC_DEFINE([HAVE_MALLOC_POSIX],[1],
      [Define if the 'malloc' function is POSIX compliant.])
  else
    REPLACE_MALLOC=1
  fi
])dnl

# Test whether malloc, realloc, calloc are POSIX compliant,
# Set gl_cv_func_malloc_posix to yes or no accordingly.
AC_DEFUN([gl_CHECK_MALLOC_POSIX],[
  AC_CACHE_CHECK([whether malloc, realloc, calloc are POSIX compliant],
                 [gl_cv_func_malloc_posix],[
      dnl# It is too dangerous to try to allocate a large amount of memory:
      dnl# some systems go to their knees when you do that. So assume that
      dnl# all Unix implementations of the function are POSIX compliant.
      AC_COMPILE_IFELSE(
        [AC_LANG_PROGRAM(
           [[]],
           [[#if (defined(_WIN32) || defined(__WIN32__)) && ! defined(__CYGWIN__)
             choke me
             #endif /* (_WIN32 || __WIN32__) && !__CYGWIN__ */
            ]])],
        [gl_cv_func_malloc_posix=yes],
        [gl_cv_func_malloc_posix=no])dnl
    ])dnl
])dnl
