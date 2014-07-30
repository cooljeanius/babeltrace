AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include

noinst_LTLIBRARIES = libcompat.la

libcompat_la_SOURCES =

libcompat_la_LDFLAGS =

libcompat_la_LIBADD = $(LIBOBJS) $(ALLOCA)

if BABELTRACE_BUILD_WITH_MINGW
libcompat_la_SOURCES += compat_uuid.c
else
libcompat_la_SOURCES += dummy.c
endif
