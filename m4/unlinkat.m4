# unlinkat.m4 serial 3
dnl# Copyright (C) 2004-2012 Free Software Foundation, Inc.
dnl# This file is free software; the Free Software Foundation
dnl# gives unlimited permission to copy and/or distribute it,
dnl# with or without modifications, as long as this notice is preserved.

# Written by Jim Meyering.

AC_DEFUN([gl_FUNC_UNLINKAT],[
  m4_ifdef([gl_UNISTD_H_DEFAULTS],[
    AC_REQUIRE([gl_UNISTD_H_DEFAULTS])dnl
  ],[
    HAVE_UNLINKAT=1;    AC_SUBST([HAVE_UNLINKAT])
    REPLACE_UNLINKAT=0; AC_SUBST([REPLACE_UNLINKAT])
  ])dnl
  AC_REQUIRE([gl_USE_SYSTEM_EXTENSIONS])dnl
  AC_CHECK_FUNCS_ONCE([unlinkat])dnl
  m4_ifdef([gl_FUNC_UNLINK],[
    AC_REQUIRE([gl_FUNC_UNLINK])dnl
  ],[
    REPLACE_UNLINK=0; AC_SUBST([REPLACE_UNLINK])
  ])dnl
  AC_REQUIRE([gl_FUNC_LSTAT_FOLLOWS_SLASHED_SYMLINK])dnl

  if test "x${ac_cv_func_unlinkat}" = "xno"; then
    HAVE_UNLINKAT=0
  else
    case "${gl_cv_func_lstat_dereferences_slashed_symlink}" in
      *no)
        # Solaris 9 has *at functions, but uniformly mishandles trailing
        # slash in all of them.
        REPLACE_UNLINKAT=1
        ;;
      *)
        # GNU/Hurd has unlinkat, but it has the same bug as unlink.
        if test ${REPLACE_UNLINK} = 1; then
          REPLACE_UNLINKAT=1
        fi
        ;;
    esac
  fi
])dnl
