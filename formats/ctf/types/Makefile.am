## automake Makefile for libctf-types

AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)/compat -I$(top_builddir)/compat -I$(top_srcdir) -I$(top_builddir)

noinst_LTLIBRARIES = libctf-types.la

libctf_types_la_SOURCES = \
	array.c \
	enum.c \
	float.c \
	integer.c \
	sequence.c \
	string.c \
	struct.c \
	variant.c

libctf_types_la_LIBADD = \
	$(top_builddir)/lib/libbabeltrace.la
