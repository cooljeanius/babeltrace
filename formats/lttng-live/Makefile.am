## automake Makefile for the lttng-live trace format

AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)/compat -I$(top_builddir)/compat -I$(top_srcdir) -I$(top_builddir)

lib_LTLIBRARIES = libbabeltrace-lttng-live.la

noinst_HEADERS = \
		 lttng-viewer-abi.h \
		 lttng-live.h

libbabeltrace_lttng_live_la_SOURCES = \
	lttng-live-plugin.c lttng-live-comm.c

# We should request that the linker keeps all static libraries objects,
# but unfortunately not all linkers support the necessary flag.
libbabeltrace_lttng_live_la_LDFLAGS = \
	-version-info $(BABELTRACE_LIBRARY_VERSION)

libbabeltrace_lttng_live_la_LIBADD = \
	$(top_builddir)/lib/libbabeltrace.la
