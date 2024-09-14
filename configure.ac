dnl#                                               -*- Autoconf -*-
dnl# Process this file with autoconf to produce a configure script.

AC_INIT([babeltrace],[1.2.2],[mathieu dot desnoyers at efficios dot com])

# Following the numbering scheme proposed by libtool for the library
# version:
# http://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html
AC_SUBST([BABELTRACE_LIBRARY_VERSION],[1:0:0])dnl

AC_CONFIG_AUX_DIR([config])dnl
AC_CANONICAL_TARGET dnl# also checks the "_HOST" version
gl_USE_SYSTEM_EXTENSIONS
AM_INIT_AUTOMAKE([1.9 gnits dist-bzip2 no-dist-gzip])
export USE_MAINTAINER_MODE=no
if test -d .git; then
  AM_MAINTAINER_MODE([enable])
else
  AM_MAINTAINER_MODE
fi
AC_SUBST([USE_MAINTAINER_MODE])dnl
m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])dnl
  ## need newline:
AM_CONDITIONAL([PASS_ON_SILENT_RULES],
               [test ${AM_DEFAULT_VERBOSITY} = 0])

AC_CONFIG_LIBOBJ_DIR([compat])dnl

AC_CONFIG_MACRO_DIR([m4])dnl

AC_PROG_MKDIR_P

AC_CONFIG_HEADERS([config.h])dnl

AC_SYS_LARGEFILE

gl_COMMON_JUST_BODY
gl_CONFIGMAKE_PREP

# Checks for programs.
if test "x${ac_cv_prog_cc_stdc}" = "x"; then
  test -z "${CC}" && test -z "${ac_cv_prog_cc_stdc}"
  AC_PROG_CC_STDC
fi
if test "x${ac_cv_prog_make_make_set}" = "x"; then
  test -z "${ac_cv_prog_make_make_set}"
  AC_PROG_MAKE_SET
fi
AC_PROG_CXX
LT_INIT([win32-dll dlopen])dnl
AC_DEFUN([AC_REQUIRE_RANLIB],[
  AC_REQUIRE([AC_PROG_RANLIB])dnl
])
if test "x${RANLIB}" = "x"; then
  test -z "${RANLIB}" && test -z "${ac_cv_prog_ac_ct_RANLIB}"
  AC_REQUIRE_RANLIB
else
  test ! -z "${RANLIB}" && export RANLIB
  AC_SUBST([RANLIB])
fi
if test "x${AR}" = "x"; then
  test -z "${AR}" || unset AR
  AC_CHECK_TOOLS([AR],[ar gar])dnl
  ## might want to switch around these checks...
  if test "x${ac_cv_prog_AR}" = "x"; then
    test -z "${ac_cv_prog_AR}" || unset ac_cv_prog_AR
    m4_ifdef([AC_PROG_AR],[
      AC_PROG_AR
    ],[
      test -x "`which ar`" && echo "first ar in path is `which ar`"
    ])
  fi
else
  test -n "${AR}" && export AR
fi
AC_PROG_YACC
AM_PROG_LEX
AC_PATH_PROG([PROVE_BIN],[prove])dnl

if test ! -f "${srcdir}/formats/ctf/metadata/ctf-parser.h"; then
  if test x"${YACC}" != x"bison -y"; then
    AC_MSG_ERROR([[bison not found and is required when building from git.
                   Please install bison]])
  fi
fi

if test ! -f "${srcdir}/formats/ctf/metadata/ctf-lexer.c"; then
  if test x"${LEX}" != x"flex"; then
    AC_MSG_ERROR([[flex not found and is required when building from git.
                   Please install flex]])
  fi
fi

# Checks for libraries.
if test "x${acl_cv_wl}" = "x"; then
  test -z "${acl_cv_wl}" && export acl_cv_wl='-Wl,'
fi
AC_SUBST([acl_cv_wl])dnl

AC_MSG_CHECKING([for linker flag to verify linked libraries have the correct architecture])
pre_saved_LDFLAGS="${LDFLAGS}"
LDFLAGS="${LDFLAGS} ${acl_cv_wl}-arch_errors_fatal"
AC_LINK_IFELSE([AC_LANG_PROGRAM([[]],[[]])],
               [LD_ARCHFLAGS="${acl_cv_wl}-arch_errors_fatal"],[])
LDFLAGS="${pre_saved_LDFLAGS}"
if test "x${LD_ARCHFLAGS}" != "x"; then
  test -n "${LD_ARCHFLAGS}"
  AC_MSG_RESULT([${LD_ARCHFLAGS}])
  if test "x${ERROR_ON_WARNING}" = "xyes"; then
    if test "x${WARN_LDFLAGS}" != "x"; then
      test -n "${WARN_LDFLAGS}" && WARN_LDFLAGS="${WARN_LDFLAGS} ${LD_ARCHFLAGS}"
    else
      test -z "${WARN_LDFLAGS}" && WARN_LDFLAGS="${LD_ARCHFLAGS}"
    fi
  fi
  AC_SUBST([LD_ARCHFLAGS])dnl
  ## that should be all we need to do with them for now...
else
  test -z "${LD_ARCHFLAGS}"
  AC_MSG_RESULT([none])
fi
LT_LIB_M
AC_CHECK_LIB([iconv],[iconv],[],[
  AC_CHECK_LIB([iconv],[libiconv],[],[
    PRE_ICONV_LDFLAGS="${LDFLAGS}"
    LDFLAGS="${LDFLAGS} ${LD_ARCHFLAGS}"
    AC_CHECK_LIB([iconv],[main],[],[])dnl
    LDFLAGS="${PRE_ICONV_LDFLAGS}"
  ])dnl
])dnl
AC_CHECK_LIB([intl],[gettext],[],[
  PRE_INTL_LDFLAGS="${LDFLAGS}"
  LDFLAGS="${LDFLAGS} ${LD_ARCHFLAGS}"
  AC_CHECK_LIB([intl],[main],[],[])dnl
  LDFLAGS="${PRE_INTL_LDFLAGS}"
])dnl

# the first two functions checked in pthreads apparently can be used
# as a replacement for thread-local storage on older versions of darwin:
AC_CHECK_LIB([pthread],[pthread_getspecific],[],[
  AC_CHECK_LIB([pthread],[pthread_setspecific],[],[
    PRE_PTHREAD_LDFLAGS="${LDFLAGS}"
    LDFLAGS="${LDFLAGS} ${LD_ARCHFLAGS}"
    AC_CHECK_LIB([pthread],[main],[],[])dnl
    LDFLAGS="${PRE_PTHREAD_LDFLAGS}"
  ])dnl
])dnl
dnl# other threading checks:
gl_THREAD
gl_XORG_TLS

dnl# (ole32 and rpcrt4 are mingw-specific and done below in that section)
dnl# (uuid, c, and popt are done even further below that)

# Check for glib.
AM_PATH_GLIB_2_0([2.22.0],[],
                 [AC_MSG_ERROR([glib is required in order to compile BabelTrace - download it from ftp://ftp.gtk.org/pub/gtk])],
                 [gmodule])dnl

# Check for gettext.
AM_GNU_GETTEXT([external])dnl
AM_GNU_GETTEXT_VERSION([0.19.8])dnl
m4_ifdef([AM_LANGINFO_CODESET],[
  if test "x${am_cv_langinfo_codeset}" = "x"; then
    test -z "${am_cv_langinfo_codeset}"
    AM_LANGINFO_CODESET
  fi
],[:])dnl

# Checks for header files.
AC_DEFUN([AC_REQUIRE_HEADER_STDC],[
  AC_REQUIRE([AC_HEADER_STDC])dnl
])dnl
AC_REQUIRE_HEADER_STDC
AC_HEADER_DIRENT
AC_HEADER_STAT
AC_HEADER_STDBOOL dnl# also "_CHECK"s it
AC_HEADER_SYS_WAIT
AC_CHECK_HEADERS([OS.h argz.h bits/wordsize.h endian.h errno.h \
                  fcntl.h float.h langinfo.h libintl.h \
                  libkern/OSByteOrder.h limits.h mach/mach.h \
                  machine/endian.h malloc.h malloc/malloc.h \
                  netdb.h netinet/in.h osreldate.h portable_endian.h \
                  shlib-compat.h stddef.h sys/endian.h sys/mount.h \
                  sys/mman.h sys/socket.h sys/statfs.h sys/statvfs.h \
                  winsock2.h wctype.h])dnl

# Keep autoscan from complaining about headers we check in other ways.
if test "x${ac_cv_header_inttypes_h}" = "x"; then
  test -z "${ac_cv_header_inttypes_h}" || unset ac_cv_header_inttypes_h
  AC_CHECK_HEADERS([inttypes.h])
fi
if test "x${ac_cv_header_locale_h}" = "x"; then
  test -z "${ac_cv_header_locale_h}" || unset ac_cv_header_locale_h
  AC_CHECK_HEADERS([locale.h])
fi
if test "x${ac_cv_header_stdio_h}" = "x"; then
  test -z "${ac_cv_header_stdio_h}" || unset ac_cv_header_stdio_h
  AC_CHECK_HEADERS([stdio.h])
fi
if test "x${ac_cv_header_stdio_ext_h}" = "x"; then
  test -z "${ac_cv_header_stdio_ext_h}" || unset ac_cv_header_stdio_ext_h
  AC_CHECK_HEADERS([stdio_ext.h])
fi
if test "x${ac_cv_header_stdint_h}" = "x"; then
  test -z "${ac_cv_header_stdint_h}" || unset ac_cv_header_stdint_h
  AC_CHECK_HEADERS([stdint.h])
fi
if test "x${ac_cv_header_sys_param_h}" = "x"; then
  test -z "${ac_cv_header_sys_param_h}" || unset ac_cv_header_sys_param_h
  AC_CHECK_HEADERS([sys/param.h])
fi
if test "x${ac_cv_header_wchar_h}" = "x"; then
  test -z "${ac_cv_header_wchar_h}" || unset ac_cv_header_wchar_h
  AC_CHECK_HEADERS([wchar.h])
fi
if test "x${ac_cv_header_unistd_h}" = "x"; then
  test -z "${ac_cv_header_unistd_h}" || unset ac_cv_header_unistd_h
  AC_CHECK_HEADERS([unistd.h])
fi

# Checks for headers that gnulib can replace (libcompat here).
gl_FCNTL_H
gl_STDIO_H
gl_HEADER_STRING_H
gl_UNISTD_H

# Checks for typedefs, structures, and compiler characteristics.
AC_C_BIGENDIAN([
  AC_CHECK_DECLS([__BIG_ENDIAN])dnl
],[
  AC_CHECK_DECLS([__LITTLE_ENDIAN])dnl
],[],[
  AC_CHECK_DECLS([__BIG_ENDIAN])dnl
  AC_CHECK_DECLS([__LITTLE_ENDIAN])dnl
])dnl
AC_C_CONST
AC_C_PROTOTYPES
AC_C_VOLATILE
AC_DEFUN([AC_REQUIRE_SOME_C_TYPES],[
  AC_REQUIRE([gl_INLINE])dnl
  AC_REQUIRE([AC_TYPE_MODE_T])dnl
  AC_REQUIRE([AC_TYPE_PID_T])dnl
])dnl
AC_REQUIRE_SOME_C_TYPES
AC_TYPE_INT8_T
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_INTMAX_T
AC_TYPE_OFF_T
if test "x${ac_cv_type_off_t}" = "xyes"; then
  AC_CHECK_SIZEOF([off_t])
  AC_CHECK_ALIGNOF([off_t])
fi
AC_CHECK_TYPES([off64_t],[
  AC_CHECK_SIZEOF([off64_t])dnl
  AC_CHECK_ALIGNOF([off64_t])dnl
],[
  if test "x${ac_cv_type_off64_t}" != "x"; then
    test -n "${ac_cv_type_off64_t}" && unset ac_cv_type_off64_t
  fi
  if test "x${ac_cv_type_off_t}" = "xyes"; then
    _AC_CHECK_TYPE_OLD([off64_t],[off_t])
  elif test "x${ac_cv_type_long_long_int}" = "xyes"; then
    _AC_CHECK_TYPE_OLD([off64_t],[long long int])
  else
    _AC_CHECK_TYPE_OLD([off64_t],[long int])
  fi
])dnl
AC_CHECK_TYPES([ptrdiff_t])dnl
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UID_T
AC_TYPE_UINT8_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_TYPE_UINTMAX_T
AC_STRUCT_TIMEZONE dnl# also does the "_TM" one

# Checks for library functions.
AC_FUNC_ALLOCA
AC_FUNC_CLOSEDIR_VOID
AC_FUNC_ERROR_AT_LINE
AC_FUNC_FORK
AC_FUNC_LSTAT dnl# also checks whether it "_FOLLOWS_SLASHED_SYMLINK"
AC_FUNC_MALLOC
AC_FUNC_MBRTOWC
AC_FUNC_MKTIME
AC_FUNC_MMAP
AC_FUNC_OBSTACK
AC_FUNC_REALLOC
AC_FUNC_STAT
AC_FUNC_STRERROR_R
AC_FUNC_STRFTIME
AC_FUNC_STRNLEN
AC_FUNC_VPRINTF
AC_CHECK_FUNCS([__argz_count __argz_next __argz_stringify atexit \
                be32toh be64toh bzero dup2 fchdir floor \
                ftruncate64 fstatfs fstatfs64 fstat64 fxstat64 \
                getcwd gethostbyname gethostname gettimeofday \
                htobe32 htobe64 iswprint localeconv localtime_r \
                lstatat mblen mbrlen memchr mempcpy memset mkdir munmap \
                nl_langinfo open posix_fallocate pread64 pwrite64 rmdir \
                send setenv setlocale socket statfs statfs64 stpcpy \
                strcasecmp strcspn strchr strdup strerror strrchr \
                strspn strstr strtoul strtoull sysconf tzset \
                uname uuid_compare])dnl

if test "x${ac_cv_func_getpagesize}" = "x"; then
  test -z "${ac_cv_func_getpagesize}" || unset ac_cv_func_getpagesize
  AC_CHECK_FUNCS([getpagesize])
fi

# Checks for functions from gnulib (libcompat here).
gl_FUNC_ALLOCA
dnl# euidaccess module:
gl_FUNC_EUIDACCESS
if test ${HAVE_EUIDACCESS} = 0; then
  AC_LIBOBJ([euidaccess])dnl
  gl_PREREQ_EUIDACCESS
fi
m4_ifdef([gl_UNISTD_MODULE_INDICATOR],[
  gl_UNISTD_MODULE_INDICATOR([euidaccess])dnl
])dnl
dnl# faccessat module:
gl_FUNC_FACCESSAT
if test ${HAVE_FACCESSAT} = 0; then
  AC_LIBOBJ([faccessat])dnl
  gl_PREREQ_FACCESSAT
fi
m4_ifdef([gl_MODULE_INDICATOR],[
  gl_MODULE_INDICATOR([faccessat])dnl
])dnl
m4_ifdef([gl_UNISTD_MODULE_INDICATOR],[
  gl_UNISTD_MODULE_INDICATOR([faccessat])dnl
])dnl
dnl# fpending module:
gl_FUNC_FPENDING
if test "x${ac_cv_func___fpending}" = "xno"; then
  AC_LIBOBJ([fpending])dnl
  gl_PREREQ_FPENDING
fi
dnl# ftruncate module:
gl_FUNC_FTRUNCATE
if test ${HAVE_FTRUNCATE} = 0 || test ${REPLACE_FTRUNCATE} = 1; then
  AC_LIBOBJ([ftruncate])dnl
  gl_PREREQ_FTRUNCATE
fi
m4_ifdef([gl_UNISTD_MODULE_INDICATOR],[
  gl_UNISTD_MODULE_INDICATOR([ftruncate])dnl
])dnl
dnl# getdelim module:
gl_FUNC_GETDELIM
if test ${HAVE_GETDELIM} = 0 || test ${REPLACE_GETDELIM} = 1; then
  AC_LIBOBJ([getdelim])dnl
  gl_PREREQ_GETDELIM
fi
m4_ifdef([gl_STDIO_MODULE_INDICATOR],[
  gl_STDIO_MODULE_INDICATOR([getdelim])dnl
])dnl
dnl# getline module:
gl_FUNC_GETLINE
if test ${REPLACE_GETLINE} = 1; then
  AC_LIBOBJ([getline])dnl
  gl_PREREQ_GETLINE
fi
m4_ifdef([gl_STDIO_MODULE_INDICATOR],[
  gl_STDIO_MODULE_INDICATOR([getline])dnl
])dnl
dnl# group-member module:
gl_FUNC_GROUP_MEMBER
if test ${HAVE_GROUP_MEMBER} = 0; then
  AC_LIBOBJ([group-member])dnl
  gl_PREREQ_GROUP_MEMBER
fi
m4_ifdef([gl_UNISTD_MODULE_INDICATOR],[
  gl_UNISTD_MODULE_INDICATOR([group-member])dnl
])dnl
dnl# lstat module:
gl_FUNC_LSTAT
if test ${REPLACE_LSTAT} = 1; then
  AC_LIBOBJ([lstat])
  gl_PREREQ_LSTAT
fi
m4_ifdef([gl_SYS_STAT_MODULE_INDICATOR],[
  gl_SYS_STAT_MODULE_INDICATOR([lstat])dnl
])dnl
dnl# malloc modules:
AC_DEFUN([gl_MALLOC_MODULES],[
  AC_REQUIRE([gl_FUNC_MALLOC_GNU])dnl
  AC_REQUIRE([gl_FUNC_MALLOC_POSIX])dnl
])dnl
gl_MALLOC_MODULES
dnl# memrchr module:
gl_FUNC_MEMRCHR
if test "x${ac_cv_func_memrchr}" = "xno"; then
  AC_LIBOBJ([memrchr])dnl
  gl_PREREQ_MEMRCHR
fi
m4_ifdef([gl_STRING_MODULE_INDICATOR],[
  gl_STRING_MODULE_INDICATOR([memrchr])dnl
])dnl
dnl# we check mmap stuff elsewhere, but let us try the gnulib checks for
dnl# mmap stuff as well here:
gl_FUNC_MMAP_ANON
dnl# openat modules:
gl_FUNC_OPENAT
m4_ifdef([gl_OPENAT_SAFER],[
  gl_OPENAT_SAFER
])
if test ${HAVE_OPENAT} = 0 || test ${REPLACE_OPENAT} = 1; then
  AC_LIBOBJ([openat])dnl
  AC_LIBOBJ([openat-proc])dnl
  gl_PREREQ_OPENAT
fi
m4_ifdef([gl_MODULE_INDICATOR],[
  gl_MODULE_INDICATOR([openat]) dnl# for lib/getcwd.c (if it exists)
  gl_MODULE_INDICATOR([openat-safer])dnl
])dnl
m4_ifdef([gl_FCNTL_MODULE_INDICATOR],[
  gl_FCNTL_MODULE_INDICATOR([openat])dnl
])dnl
dnl# posix_fallocate modules:
gl_FUNC_FALLOCATE
gl_FUNC_POSIX_FALLOCATE
gl_FUNC_POSIX_FALLOCATE64
dnl# pread module:
gl_FUNC_PREAD
if test ${HAVE_PREAD} = 0 || test ${REPLACE_PREAD} = 1; then
  AC_LIBOBJ([pread])
fi
m4_ifdef([gl_UNISTD_MODULE_INDICATOR],[
  gl_UNISTD_MODULE_INDICATOR([pread])dnl
])dnl
dnl# pwrite module:
gl_FUNC_PWRITE
if test ${HAVE_PWRITE} = 0 || test ${REPLACE_PWRITE} = 1; then
  AC_LIBOBJ([pwrite])
fi
m4_ifdef([gl_UNISTD_MODULE_INDICATOR],[
  gl_UNISTD_MODULE_INDICATOR([pwrite])dnl
])dnl
dnl# strndup module:
gl_FUNC_STRNDUP
if test ${HAVE_STRNDUP} = 0 || test ${REPLACE_STRNDUP} = 1; then
  AC_LIBOBJ([strndup])
fi
m4_ifdef([gl_STRING_MODULE_INDICATOR],[
  gl_STRING_MODULE_INDICATOR([strndup])dnl
])dnl
dnl# strnlen module:
gl_FUNC_STRNLEN
if test ${HAVE_DECL_STRNLEN} = 0 || test ${REPLACE_STRNLEN} = 1; then
  AC_LIBOBJ([strnlen])dnl
  gl_PREREQ_STRNLEN
fi
m4_ifdef([gl_STRING_MODULE_INDICATOR],[
  gl_STRING_MODULE_INDICATOR([strnlen])dnl
])dnl
dnl# unlink module:
gl_FUNC_UNLINK
if test ${REPLACE_UNLINK} = 1; then
  AC_LIBOBJ([unlink])
fi
m4_ifdef([gl_UNISTD_MODULE_INDICATOR],[
  gl_UNISTD_MODULE_INDICATOR([unlink])dnl
])dnl
dnl# unlinkat module:
gl_FUNC_UNLINKAT
if test ${HAVE_UNLINKAT} = 0 || test ${REPLACE_UNLINKAT} = 1; then
  AC_LIBOBJ([unlinkat])
fi
m4_ifdef([gl_UNISTD_MODULE_INDICATOR],[
  gl_UNISTD_MODULE_INDICATOR([unlinkat])dnl
])dnl
dnl# unlocked-io module:
gl_FUNC_GLIBC_UNLOCKED_IO

# Keep autoscan from complaining about functions we replace.
if test "x${ac_cv_func_euidaccess}" = "x"; then
  test -z "${ac_cv_func_euidaccess}"
  AC_CHECK_FUNCS([euidaccess])
fi
if test "x${ac_cv_func___fpending}" = "x"; then
  test -z "${ac_cv_func___fpending}"
  AC_CHECK_FUNCS([__fpending])
fi
if test "x${ac_cv_func_ftruncate}" = "x"; then
  test -z "${ac_cv_func_ftruncate}"
  AC_CHECK_FUNCS([ftruncate])
fi
if test "x${ac_cv_func_getdelim}" = "x"; then
  test -z "${ac_cv_func_getdelim}"
  AC_CHECK_FUNCS([getdelim])
fi
if test "x${ac_cv_func_getline}" = "x"; then
  test -z "${ac_cv_func_getline}"
  AC_CHECK_FUNCS([getline])
fi
if test "x${ac_cv_func_strndup}" = "x"; then
  test -z "${ac_cv_func_strndup}"
  AC_CHECK_FUNCS([strndup])
fi
if test "x${ac_cv_func_unlinkat}" = "x"; then
  test -z "${ac_cv_func_unlinkat}"
  AC_CHECK_FUNCS([unlinkat])
fi

# Checks for declarations.
AC_CHECK_DECLS([program_invocation_name],[],[],[#include <errno.h>])dnl
AC_CHECK_DECLS([program_invocation_short_name],[],[],[#include <errno.h>])
AC_CHECK_DECLS([_STAT_VER])dnl
AC_CHECK_DECLS([MSG_NOSIGNAL],[],[
  AC_CHECK_DECLS([SO_NOSIGPIPE],[],[],[
#if defined(HAVE_SYS_SOCKET_H)
# include <sys/socket.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "This conftest for SO_NOSIGPIPE wants to include <sys/socket.h>"
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_SYS_SOCKET_H */
  ])dnl
],[
#if defined(HAVE_SYS_SOCKET_H)
# include <sys/socket.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "This conftest for MSG_NOSIGNAL wants to include <sys/socket.h>"
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_SYS_SOCKET_H */
])dnl
AC_CHECK_DECLS([MAP_ANONYMOUS],[],[
  AC_CHECK_DECLS([MAP_ANON],[],[],[
#include <stdlib.h>
#if defined(HAVE_SYS_TYPES_H)
# include <sys/types.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "This conftest for MAP_ANON wants to include <sys/types.h>"
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_SYS_TYPES_H */
#ifndef _DARWIN_C_SOURCE
# ifdef __APPLE__
#  define _DARWIN_C_SOURCE 1
# endif /* __APPLE__ */
#endif /* !_DARWIN_C_SOURCE */
#if defined(HAVE_SYS_MMAN_H)
# include <sys/mman.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "This conftest for MAP_ANON wants to include <sys/mman.h>"
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_SYS_MMAN_H */
  ])dnl
],[
#include <stdlib.h>
#if defined(HAVE_SYS_TYPES_H)
# include <sys/types.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "This conftest for MAP_ANONYMOUS wants to include <sys/types.h>"
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_SYS_TYPES_H */
#if defined(HAVE_SYS_MMAN_H)
# include <sys/mman.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "This conftest for MAP_ANONYMOUS wants to include <sys/mman.h>"
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_SYS_MMAN_H */
])dnl
AC_CHECK_DECLS([HOST_NAME_MAX],[],[
  AC_CHECK_DECLS([_POSIX_HOST_NAME_MAX],[],[],[
#ifdef _ANSI_SOURCE
# undef _ANSI_SOURCE
#endif /* _ANSI_SOURCE */
#if defined(HAVE_LIMITS_H)
# include <limits.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "conftest for _POSIX_HOST_NAME_MAX wants <limits.h>"
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_LIMITS_H */
  ])dnl
  AC_CHECK_DECLS([_SC_HOST_NAME_MAX])dnl
])dnl

dnl# http://lists.apple.com/archives/macnetworkprog/2002/Dec/msg00091.html
AH_BOTTOM([
#if !defined(MSG_NOSIGNAL) && (!defined(HAVE_DECL_MSG_NOSIGNAL) || (defined(HAVE_DECL_MSG_NOSIGNAL) && !HAVE_DECL_MSG_NOSIGNAL))
# if defined(SO_NOSIGPIPE) && (defined(HAVE_DECL_SO_NOSIGPIPE) && HAVE_DECL_SO_NOSIGPIPE)
#  define MSG_NOSIGNAL SO_NOSIGPIPE
# else
#  define MSG_NOSIGNAL 0x2000
# endif /* SO_NOSIGPIPE && HAVE_DECL_SO_NOSIGPIPE */
#endif /* !MSG_NOSIGNAL && !HAVE_DECL_MSG_NOSIGNAL */

#if !defined(MAP_ANONYMOUS) && (!defined(HAVE_DECL_MAP_ANONYMOUS) || (defined(HAVE_DECL_MAP_ANONYMOUS) && !HAVE_DECL_MAP_ANONYMOUS))
# if defined(MAP_ANON) && (defined(HAVE_DECL_MAP_ANON) && HAVE_DECL_MAP_ANON)
#  define MAP_ANONYMOUS MAP_ANON
# else
#  define MAP_ANONYMOUS 0x1000
# endif /* MAP_ANON && HAVE_DECL_MAP_ANON */
#endif /* !MAP_ANONYMOUS && !HAVE_DECL_MAP_ANONYMOUS */

#if !defined(HOST_NAME_MAX) && (!defined(HAVE_DECL_HOST_NAME_MAX) || (defined(HAVE_DECL_HOST_NAME_MAX) && !HAVE_DECL_HOST_NAME_MAX))
# if defined(_POSIX_HOST_NAME_MAX) && (defined(HAVE_DECL__POSIX_HOST_NAME_MAX) && HAVE_DECL__POSIX_HOST_NAME_MAX)
#  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
# else
#  if defined(_SC_HOST_NAME_MAX) && (defined(HAVE_DECL__SC_HOST_NAME_MAX) && HAVE_DECL__SC_HOST_NAME_MAX)
#   define HOST_NAME_MAX _SC_HOST_NAME_MAX
#  else
#   define HOST_NAME_MAX 255
#  endif /* _SC_HOST_NAME_MAX && HAVE_DECL__SC_HOST_NAME_MAX */
# endif /* _POSIX_HOST_NAME_MAX && HAVE_DECL__POSIX_HOST_NAME_MAX */
#endif /* !HOSTNAME_MAX && !HAVE_DECL_HOSTNAME_MAX */
])dnl

# Check for MinGW32.
MINGW32=no
case ${host} in
  *-*-mingw*)
    MINGW32=yes
    # FIXME: Replace `main' with a function in `-lole32':
    AC_CHECK_LIB([ole32],[main])
    # FIXME: Replace `main' with a function in `-lrpcrt4':
    AC_CHECK_LIB([rpcrt4],[main])
    ;;
esac

AM_CONDITIONAL([BABELTRACE_BUILD_WITH_MINGW],
               [test "x${MINGW32}" = "xyes"])dnl

# Check for libuuid:
AC_CHECK_LIB([uuid],[uuid_generate],[
  AC_DEFINE_UNQUOTED([BABELTRACE_HAVE_LIBUUID],[1],
                     [Define to 1 if we have libuuid support.])
  have_libuuid=yes
],[
  # libuuid not found, check for uuid_create in libc:
  AC_CHECK_LIB([c],[uuid_create],[
    AC_DEFINE_UNQUOTED([BABELTRACE_HAVE_LIBC_UUID],[1],
                       [Define to 1 if we have libc uuid support.])
    have_libc_uuid=yes
  ],[
    # for MinGW32 we have our own internal implemenation of uuid
    # using Windows functions:
    if test "x${MINGW32}" = "xno"; then
      AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Use [LDFLAGS]=-Ldir to specify their location.])
    fi
  ])dnl
])dnl
AM_CONDITIONAL([BABELTRACE_BUILD_WITH_LIBUUID],
               [test "x${have_libuuid}" = "xyes"])dnl
AM_CONDITIONAL([BABELTRACE_BUILD_WITH_LIBC_UUID],
               [test "x${have_libc_uuid}" = "xyes"])dnl

# Check for fmemopen:
AC_CHECK_LIB([c],[fmemopen],[
  AC_DEFINE_UNQUOTED([BABELTRACE_HAVE_FMEMOPEN],[1],
                     [Define to 1 if we have fmemopen support in libc.])dnl
])dnl

# Check for open_memstream:
AC_CHECK_LIB([c],[open_memstream],[
  AC_DEFINE_UNQUOTED([BABELTRACE_HAVE_OPEN_MEMSTREAM],[1],
                     [Define to 1 if we have open_memstream support.])dnl
])dnl

AC_CHECK_LIB([popt],[poptGetContext],[],[
  AC_MSG_ERROR([Cannot find popt.])dnl
])dnl


# For Python
# SWIG version needed or newer:
swig_version=2.0.0

AC_ARG_ENABLE([python-bindings],
              [AS_HELP_STRING([--enable-python-bindings],
                              [generate Python bindings])],
              [enable_python=yes],[enable_python=no])dnl

AM_CONDITIONAL([USE_PYTHON],[test "x${enable_python:-yes}" = "xyes"])dnl

if test "x${enable_python:-yes}" = "xyes"; then
  AX_PKG_SWIG([${swig_version}],[],[
    AC_MSG_ERROR([SWIG ${swig_version} or newer is needed for python])dnl
  ])dnl

  dnl# We require python3, so unset PYTHONPATH if it contains python2:
  if test "x`echo ${PYTHONPATH} | grep python2`" != "x"; then
    export BACKUP_PYTHONPATH_FOR_PYTHON2="${PYTHONPATH}"
    AC_SUBST([BACKUP_PYTHONPATH_FOR_PYTHON2])
    unset PYTHONPATH
  else
    AC_SUBST([PYTHONPATH])
    :
  fi
  AM_PATH_PYTHON([3.0])dnl

  AC_ARG_VAR([PYTHON_INCLUDE],
             [Include flags for python, bypassing python-config])dnl
  AC_ARG_VAR([PYTHON_CONFIG],[Path to python-config])dnl
  AS_IF([test -z "${PYTHON_INCLUDE}"],[
    AS_IF([test -z "${PYTHON_CONFIG}"],[
      AC_PATH_PROGS([PYTHON_CONFIG],
                    [python${PYTHON_VERSION}-config python-config],
                    [no],
                    [`dirname ${PYTHON}`])dnl
      AS_IF([test "x${PYTHON_CONFIG}" = "xno"],
            [AC_MSG_ERROR([cannot find python-config for ${PYTHON}. Do you have the development headers for python installed?])dnl
      ])dnl
    ])dnl

    AC_MSG_CHECKING([python include flags])
    PYTHON_INCLUDE=`${PYTHON_CONFIG} --includes`
    AC_MSG_RESULT([${PYTHON_INCLUDE}])dnl
  ])dnl

else
  AC_MSG_NOTICE([You may configure with --enable-python-bindings ]dnl
[if you want Python bindings.])dnl

  # this hack breaks the python bindings, so only do it here:
  case ${host_os} in
    darwin*)
      # dirty hack to get ./include/babeltrace/endian.h to use the correct
      # header on darwin (freebsd should already define this by default):
      if test "x${CPPFLAGS}" = "x"; then
        test -z "${CPPFLAGS}" && export CPPFLAGS='-D__FreeBSD__=5'
      fi
      ;;
  esac
fi

case ${host_os} in
  darwin*)
    # try to silence warnings about functions ending in "64" being
    # deprecated by forcing deployment target to Leopard:
    saved_CFLAGS="${CFLAGS}"
    CFLAGS="${CFLAGS} -mmacosx-version-min=10.5"
    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[]],[[]])],
                      [],[CFLAGS="${saved_CFLAGS}"])dnl
    ;;
esac

# Add some compiler flag checks near the end.
AC_MSG_CHECKING([support for -Wl,--no-as-needed linker flag])
NO_AS_NEEDED_LDFLAGS=""
saved_LDFLAGS="${LDFLAGS}"
LDFLAGS="${LDFLAGS} -Wl,--no-as-needed"
AC_LINK_IFELSE([AC_LANG_PROGRAM([[]],[[]])],
               [NO_AS_NEEDED_LDFLAGS="-Wl,--no-as-needed"],[])dnl
AC_SUBST([NO_AS_NEEDED_LDFLAGS])
LDFLAGS="${saved_LDFLAGS}"
if test "x${NO_AS_NEEDED_LDFLAGS}" = "x"; then
  test -z "${NO_AS_NEEDED_LDFLAGS}"
  AC_MSG_RESULT([no])
else
  test -n "${NO_AS_NEEDED_LDFLAGS}"
  AC_MSG_RESULT([yes])
fi

pkg_modules="gmodule-2.0 >= 2.0.0"
PKG_CHECK_MODULES([GMODULE],[${pkg_modules}])dnl
AC_SUBST([PACKAGE_LIBS])dnl

LIBS="${LIBS} ${GMODULE_LIBS}"

# Compiler warnings section:
XORG_COMPILER_BRAND
if test "x${CLANGCC}" = "xyes"; then
  PRE_CLANG_CFLAGS="${CFLAGS}"
  CFLAGS="${CFLAGS} -Werror=unknown-warning-option"
fi
dnl#TODO: add a configure flag to enable the warnings conditionally:
gl_MANYWARN_ALL_GCC([warnings_to_check])
warnings_to_skip=""
warnings_to_skip="${warnings_to_skip} -W"          # redundant with -Wextra
warnings_to_skip="${warnings_to_skip} -Wsystem-headers"         # unfixable
warnings_to_skip="${warnings_to_skip} -Wvla"        # warnings in gettext.h
warnings_to_skip="${warnings_to_skip} -Wsuggest-attribute=const"      # ???
warnings_to_skip="${warnings_to_skip} -Wsuggest-attribute=format"     # ???
warnings_to_skip="${warnings_to_skip} -Wsuggest-attribute=noreturn"   # ???
warnings_to_skip="${warnings_to_skip} -Wsuggest-attribute=pure"       # ???
warnings_to_skip="${warnings_to_skip} -Wmissing-format-attribute"     # ???
warnings_to_skip="${warnings_to_skip} -Wtraditional"     # not for new code
warnings_to_skip="${warnings_to_skip} -Wcast-qual"      # I use casts a lot
warnings_to_skip="${warnings_to_skip} -Wredundant-decls"  # redundancy=good
warnings_to_skip="${warnings_to_skip} -Wpedantic"        # too many for now
warnings_to_skip="${warnings_to_skip} -Wpadded"        # no idea how to fix
warnings_to_skip="${warnings_to_skip} -Wunused-macros"      # log pollution
warnings_to_skip="${warnings_to_skip} -Wformat-y2k"             # pointless
warnings_to_skip="${warnings_to_skip} -Wformat-zero-length"     # redundant
warnings_to_skip="${warnings_to_skip} -Wformat-security"        # redundant 
warnings_to_skip="${warnings_to_skip} -Wformat-nonliteral"      # redundant 
warnings_to_skip="${warnings_to_skip} -Wformat-extra-args"      # redundant 
warnings_to_skip="${warnings_to_skip} -Wformat-contains-nul"    # redundant
warnings_to_skip="${warnings_to_skip} -Wformat-signedness"      # redundant
warnings_to_skip="${warnings_to_skip} -Wtraditional-conversion"  # too many
warnings_to_skip="${warnings_to_skip} -Wsign-conversion" # too many for now
warnings_to_skip="${warnings_to_skip} -Wconversion"      # too many for now
warnings_to_skip="${warnings_to_skip} -Winline"  # not sure if needs fixing
warnings_to_skip="${warnings_to_skip} -Wunused-parameter" # too lazy to fix
warnings_to_skip="${warnings_to_skip} -Wunused"           # too lazy to fix
warnings_to_skip="${warnings_to_skip} -Wsign-compare"    # too many for now
warnings_to_skip="${warnings_to_skip} -Wpacked"       # not sure if correct
warnings_to_skip="${warnings_to_skip} -Wpointer-arith" # no idea how to fix
warnings_to_skip="${warnings_to_skip} -Wc++-compat"      # too many for now
warnings_to_skip="${warnings_to_skip} -Wswitch-enum"                  # meh
warnings_to_skip="${warnings_to_skip} -Waggregate-return"             # ???
warnings_to_skip="${warnings_to_skip} -Wwrite-strings" # too many for tests
warnings_to_skip="${warnings_to_skip} -Wshadow"     # too many with old gcc
warnings_to_skip="${warnings_to_skip} -Wunreachable-code"     # often wrong
warnings_to_skip="${warnings_to_skip} -Wtype-limits" # triggered on purpose
warnings_to_skip="${warnings_to_skip} -Wbad-function-cast"             # ok
warnings_to_skip="${warnings_to_skip} -Wchkp"         # no longer supported
warnings_to_skip="${warnings_to_skip} -Wabi"    # requires a numerical arg.
if test "x${CLANGCC}" = "xyes"; then
  warnings_to_skip="${warnings_to_skip} -Wcast-align"   # I use casts a lot
  warnings_to_skip="${warnings_to_skip} -Wvariadic-macros"   # too pedantic
fi
case ${host_cpu} in
  aarch64 | powerpc64 | x86_64)
    warnings_to_skip="${warnings_to_skip} -Wlong-long"  # "long long"=64bit
    ;;
esac
# skip when optimization has not been explicitly requested:
if test x${CFLAGS+set} = xset; then
  case "${CFLAGS}" in
    *"-O0"* ) 
      warnings_to_skip="${warnings_to_skip} -Wunsafe-loop-optimizations"
      ;;
    *"-O"* )
      ;;
  esac
else
  warnings_to_skip="${warnings_to_skip} -Wunsafe-loop-optimizations"
fi
gl_WARN_ADD([-Wno-sign-compare])
gl_WARN_ADD([-Wno-unused-parameter])
gl_WARN_ADD([-Wno-shift-negative-value])
gl_WARN_ADD([-Wno-type-limits])
gl_WARN_ADD([-fno-strict-overflow])
gl_MANYWARN_COMPLEMENT([actual_warnings_to_check],
                       [${warnings_to_check}],
                       [${warnings_to_skip}])
gl_COMPILER_OPTION_IF([-Wshift-overflow=2],
                      [WARN_CFLAGS="${WARN_CFLAGS} -Wshift-overflow=2"],
                      [gl_WARN_ADD([-Wshift-overflow])])
gl_WARN_ADD([-Wnull-dereference])
gl_WARN_ADD([-Wduplicated-cond])
gl_WARN_ADD([-Wmisleading-indentation])
gl_WARN_ADD([-Wdangling-else])
gl_WARN_ADD([-Wduplicate-decl-specifier])
gl_WARN_ADD([-Wmemset-elt-size])
gl_WARN_ADD([-Wswitch-unreachable])
gl_WARN_ADD([-Wimplicit-fallthrough])
gl_COMPILER_OPTION_IF([-Wformat-overflow=2],
                      [WARN_CFLAGS="${WARN_CFLAGS} -Wformat-overflow=2"],
                      [gl_WARN_ADD([-Wformat-overflow])])
gl_COMPILER_OPTION_IF([-Wformat-truncation=2],
                      [WARN_CFLAGS="${WARN_CFLAGS} -Wformat-truncation=2"],
                      [gl_WARN_ADD([-Wformat-truncation])])
gl_COMPILER_OPTION_IF([-Wstringop-overflow=2],
                      [WARN_CFLAGS="${WARN_CFLAGS} -Wstringop-overflow=2"],
                      [gl_WARN_ADD([-Wstringop-overflow])])
gl_WARN_ADD([-Wexpansion-to-defined])
gl_WARN_ADD([-Wrestrict])
gl_WARN_ADD([-Wint-in-bool-context])
gl_WARN_ADD([-Wpointer-compare])
gl_WARN_ADD([-Wbool-operation])
gl_WARN_ADD([-Walloc-zero])
gl_WARN_ADD([-Wpsabi])
gl_WARN_ADD([-Wbuiltin-declaration-mismatch])
for fsf_gcc_warnflag in ${actual_warnings_to_check}; do
  gl_WARN_ADD([${fsf_gcc_warnflag}])
done
case ${host_vendor} in
  apple)
    # manywarnings.m4 is missing these Apple-gcc-specific flags:
    for apple_gcc_warnflag in \
      -Wfour-char-constants \
      -Wnewline-eof \
      -Wshorten-64-to-32 \
      -Wextra-tokens \
      -Waltivec-long-deprecated \
      \
      ; do
      dnl# (was actually just a typo)
      gl_WARN_ADD([${apple_gcc_warnflag}])
    done
    ;;
esac

if test "x${CLANGCC}" = "xyes"; then
  test -n "${PRE_CLANG_CFLAGS}" && CFLAGS="${PRE_CLANG_CFLAGS}"
fi

PACKAGE_CFLAGS="${GMODULE_CFLAGS} ${WARN_CFLAGS} -include config.h"
AC_SUBST([PACKAGE_CFLAGS])dnl

babeltraceincludedir="${includedir}/babeltrace"
AC_SUBST([babeltraceincludedir])dnl

babeltracectfincludedir="${includedir}/babeltrace/ctf"
AC_SUBST([babeltracectfincludedir])dnl

babeltracectfwriterincludedir="${includedir}/babeltrace/ctf-writer"
AC_SUBST([babeltracectfwriterincludedir])dnl

babeltracectfirincludedir="${includedir}/babeltrace/ctf-ir"
AC_SUBST([babeltracectfirincludedir])dnl

# Output:
AC_CONFIG_FILES([
  Makefile
  types/Makefile
  compat/Makefile
  formats/Makefile
  formats/ctf/Makefile
  formats/ctf/types/Makefile
  formats/ctf-text/Makefile
  formats/ctf-text/types/Makefile
  formats/ctf-metadata/Makefile
  formats/bt-dummy/Makefile
  formats/lttng-live/Makefile
  formats/ctf/ir/Makefile
  formats/ctf/metadata/Makefile
  formats/ctf/writer/Makefile
  converter/Makefile
  doc/Makefile
  lib/Makefile
  lib/prio_heap/Makefile
  include/Makefile
  bindings/Makefile
  bindings/python/Makefile
  po/Makefile.in
  po/Makevars
  tests/Makefile
  tests/bin/Makefile
  tests/lib/Makefile
  tests/utils/Makefile
  tests/utils/tap/Makefile
  extras/Makefile
  extras/valgrind/Makefile
  babeltrace.pc
  babeltrace-ctf.pc
])dnl
AC_OUTPUT

echo ""
echo "Configuration results:"
echo ""
echo "Compiler: '${CC}'"
echo "Ordinary compiler flags: '${CFLAGS}'"
echo "Package compiler flags: '${PACKAGE_CFLAGS}'"
echo "Preprocessor flags: '${CPPFLAGS}'"
echo "Linker flags: '${LDFLAGS} ${NO_AS_NEEDED_LDFLAGS}'"
echo "Ordinary libraries to link against: '${LIBS}'"
echo "Regenerate files after any little change: '${USE_MAINTAINER_MODE}'"
echo "Verbosity level: '${AM_DEFAULT_VERBOSITY}'"
echo ""
