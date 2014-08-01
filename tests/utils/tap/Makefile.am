## automake Makefile for the libtap used for the libbabeltrace testsuite

check_LTLIBRARIES = libtap.la
libtap_la_SOURCES = tap.c tap.h

SCRIPT_LIST = tap.sh

dist_check_SCRIPTS = $(SCRIPT_LIST)

all-local:
	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
		for script in $(SCRIPT_LIST); do \
			cp -fv $(srcdir)/$${script} $(builddir); \
		done; \
	fi
.PHONY: all-local

clean-local:
	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
		for script in $(SCRIPT_LIST); do \
			rm -f $(builddir)/$${script}; \
		done; \
	fi
.PHONY: clean-local
