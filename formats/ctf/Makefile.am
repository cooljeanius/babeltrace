## automake Makefile for the CTF (Common Trace Format)

AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)/compat -I$(top_builddir)/compat -I$(top_srcdir) -I$(top_builddir)

SUBDIRS = types metadata writer ir .

lib_LTLIBRARIES = libbabeltrace-ctf.la

libbabeltrace_ctf_la_SOURCES = \
	ctf.c \
	events.c \
	iterator.c \
	callbacks.c \
	events-private.h

# We should request that the linker keeps all static libraries objects,
# but unfortunately not all linkers support the necessary flag.
libbabeltrace_ctf_la_LDFLAGS = \
	@NO_AS_NEEDED_LDFLAGS@ -version-info $(BABELTRACE_LIBRARY_VERSION)

libbabeltrace_ctf_la_LIBADD = \
	$(top_builddir)/lib/libbabeltrace.la \
	types/libctf-types.la \
	metadata/libctf-parser.la \
	metadata/libctf-ast.la \
	writer/libctf-writer.la \
	ir/libctf-ir.la
