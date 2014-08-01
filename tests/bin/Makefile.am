## automake Makefile for libbabeltrace helper programs

SCRIPT_LIST = test_trace_read

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
