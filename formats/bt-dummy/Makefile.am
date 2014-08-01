## automake Makefile for libbabeltrace dummy library

AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include

lib_LTLIBRARIES = libbabeltrace-dummy.la

libbabeltrace_dummy_la_SOURCES = \
	bt-dummy.c

# We should request that the linker keeps all static libraries objects,
# but unfortunately not all linkers support the necessary flag.
libbabeltrace_dummy_la_LDFLAGS = \
	-version-info $(BABELTRACE_LIBRARY_VERSION)

libbabeltrace_dummy_la_LIBADD = \
	$(top_builddir)/lib/libbabeltrace.la
