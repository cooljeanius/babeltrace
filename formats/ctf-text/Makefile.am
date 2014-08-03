## automake Makefile for the ctf-text trace format

AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include

SUBDIRS = types .

lib_LTLIBRARIES = libbabeltrace-ctf-text.la

libbabeltrace_ctf_text_la_SOURCES = \
	ctf-text.c

# We should request that the linker keeps all static libraries objects,
# but unfortunately not all linkers support the necessary flag.
libbabeltrace_ctf_text_la_LDFLAGS = \
	@NO_AS_NEEDED_LDFLAGS@ -version-info $(BABELTRACE_LIBRARY_VERSION) \
	types/libctf-text-types.la

libbabeltrace_ctf_text_la_LIBADD = \
	$(top_builddir)/lib/libbabeltrace.la \
	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la
