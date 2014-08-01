# serial 6
# See if we need to provide faccessat replacement.

dnl# Copyright (C) 2009-2012 Free Software Foundation, Inc.
dnl# This file is free software; the Free Software Foundation
dnl# gives unlimited permission to copy and/or distribute it,
dnl# with or without modifications, as long as this notice is preserved.

# Written by Eric Blake.

AC_DEFUN([gl_FUNC_FACCESSAT],[
  m4_ifdef([gl_UNISTD_H_DEFAULTS],[
    AC_REQUIRE([gl_UNISTD_H_DEFAULTS])dnl
  ],[
    HAVE_FACCESSAT=1; AC_SUBST([HAVE_FACCESSAT])
  ])dnl

  dnl# Persuade glibc <unistd.h> to declare faccessat() for us:
  AC_REQUIRE([gl_USE_SYSTEM_EXTENSIONS])dnl

  AC_CHECK_FUNCS_ONCE([faccessat])dnl

  if test "x${ac_cv_func_faccessat}" = "xno"; then
    HAVE_FACCESSAT=0
  fi
])dnl

# Prerequisites of lib/faccessat.m4.
AC_DEFUN([gl_PREREQ_FACCESSAT],[
  AC_CHECK_FUNCS_ONCE([access])dnl
])dnl
