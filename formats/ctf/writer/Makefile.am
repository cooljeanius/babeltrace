## automake Makefile for libctf-writer

AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)/compat -I$(top_builddir)/compat -I$(top_srcdir) -I$(top_builddir)

noinst_LTLIBRARIES = libctf-writer.la

libctf_writer_la_SOURCES = \
	writer.c \
	functor.c

libctf_writer_la_LIBADD = \
	$(top_builddir)/lib/libbabeltrace.la

if BABELTRACE_BUILD_WITH_LIBUUID
libctf_writer_la_LIBADD += -luuid
endif
if BABELTRACE_BUILD_WITH_LIBC_UUID
libctf_writer_la_LIBADD += -lc
endif
