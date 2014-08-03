## automake Makefile for the ctf-metadata trace format

AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include

lib_LTLIBRARIES = libbabeltrace-ctf-metadata.la

libbabeltrace_ctf_metadata_la_SOURCES = \
	ctf-metadata.c

# We should request that the linker keeps all static libraries objects,
# but unfortunately not all linkers support the necessary flag.
libbabeltrace_ctf_metadata_la_LDFLAGS = \
	@NO_AS_NEEDED_LDFLAGS@ -version-info $(BABELTRACE_LIBRARY_VERSION)

libbabeltrace_ctf_metadata_la_LIBADD = \
	$(top_builddir)/lib/libbabeltrace.la
