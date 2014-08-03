# euidaccess.m4 serial 15
dnl# Copyright (C) 2002-2012 Free Software Foundation, Inc.
dnl# This file is free software; the Free Software Foundation
dnl# gives unlimited permission to copy and/or distribute it,
dnl# with or without modifications, as long as this notice is preserved.

AC_DEFUN([gl_FUNC_NONREENTRANT_EUIDACCESS],[
  AC_REQUIRE([gl_FUNC_EUIDACCESS])dnl
  AC_DEFINE([PREFER_NONREENTRANT_EUIDACCESS],[1],
    [Define this if you prefer euidaccess to return the correct result
     even if this would make it nonreentrant.  Define this only if your
     entire application is safe even if the uid or gid might temporarily
     change.  If your application uses signal handlers or threads it
     is probably not safe.])dnl
])dnl

AC_DEFUN([gl_FUNC_EUIDACCESS],[
  m4_ifdef([gl_UNISTD_H_DEFAULTS],[
    AC_REQUIRE([gl_UNISTD_H_DEFAULTS])dnl
  ],[
    HAVE_EUIDACCESS=1; AC_SUBST([HAVE_EUIDACCESS])
  ])dnl

  dnl# Persuade glibc <unistd.h> to declare euidaccess() for us:
  AC_REQUIRE([AC_USE_SYSTEM_EXTENSIONS])dnl

  AC_CHECK_FUNCS([euidaccess])dnl

  if test "x${ac_cv_func_euidaccess}" = "xno"; then
    HAVE_EUIDACCESS=0
  fi
])dnl

# Prerequisites of lib/euidaccess.c.
AC_DEFUN([gl_PREREQ_EUIDACCESS],[
  dnl# Prefer POSIX faccessat over non-standard euidaccess:
  AC_CHECK_FUNCS_ONCE([faccessat])dnl
  dnl# Try various other non-standard fallbacks:
  AC_CHECK_HEADERS_ONCE([libgen.h])dnl
  AC_CHECK_DECLS_ONCE([setregid])dnl
  AC_REQUIRE([AC_FUNC_GETGROUPS])dnl

  # Solaris 9 and 10 need -lgen to get the eaccess function.
  # Save and restore LIBS so -lgen is NOT added to it. Otherwise, *all*
  # programs in the package would end up linked with that
  # potentially-shared library, inducing unnecessary run-time overhead.
  LIB_EACCESS=""
  AC_SUBST([LIB_EACCESS])
  gl_saved_libs="${LIBS}"
    AC_SEARCH_LIBS([eaccess],[gen],
                   [test "x${ac_cv_search_eaccess}" = "xnone required" ||
                    LIB_EACCESS="${ac_cv_search_eaccess}"])dnl
    AC_CHECK_FUNCS([eaccess])
  LIBS="${gl_saved_libs}"
])dnl