## automake Makefile for libbabeltrace testsuite

SUBDIRS = utils bin lib

EXTRA_DIST = ctf-traces/**
EXTRA_DIST += tests

dist_check_DATA = tests

SCRIPT_LIST = run.sh

dist_check_SCRIPTS = $(SCRIPT_LIST)

THING_LIST = $(dist_check_SCRIPTS) $(dist_check_DATA)

all-local:
	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
		for thing in $(THING_LIST); do \
			cp -fv $(srcdir)/$${thing} $(builddir); \
		done; \
	fi
.PHONY: all-local

clean-local:
	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
		for thing in $(THING_LIST); do \
			rm -f $(builddir)/$${thing}; \
		done; \
	fi
.PHONY: clean-local

check-am: ./run.sh tests
	./run.sh tests
.PHONY: check-am
