## top-level automake Makefile for libbabeltrace

AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include

ACLOCAL_AMFLAGS = -I m4 --install

SUBDIRS = include types compat lib formats converter bindings tests doc extras po

dist_doc_DATA = ChangeLog LICENSE mit-license.txt gpl-2.0.txt \
		std-ext-lib.txt README

dist_noinst_DATA = CodingStyle

EXTRA_DIST = po/Makevars.in

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = babeltrace.pc babeltrace-ctf.pc

CLEANFILES = .DS_Store
DISTCLEANFILES = .DS_Store *~ autoscan.log m4/.DS_Store m4/*~
DISTCLEANFILES += config/*~ po/.DS_Store po/*~

distclean-local:
	rm -fv @PACKAGE_TARNAME@-@PACKAGE_VERSION@.tar.bz2
	rm -rfv autom4te.cache || rmdir autom4te.cache
	rm -rfv .deps || rmdir .deps
	-(test -w @PACKAGE_TARNAME@-@PACKAGE_VERSION@ && (rm -rf @PACKAGE_TARNAME@-@PACKAGE_VERSION@ || rmdir @PACKAGE_TARNAME@-@PACKAGE_VERSION@)) || stat @PACKAGE_TARNAME@-*.*.* || echo "it can be difficult to distclean the results of distcheck"
	-(find . -name .DS_Store -delete 2>&1) || test -x "`which find`"
.PHONY: distclean-local

## maintainer stuff:
nodist_noinst_DATA = @MAINT@ configure.scan
configure.scan:
	autoscan || touch configure.scan

## initialize this variable:
MAINTAINERCLEANFILES = configure.scan

## this too:
AM_DISTCHECK_CONFIGURE_FLAGS = @MAINT@
## (maintainer mode flags should be unnecessary to tweak, because they are
## dependent on being in a git repository, and distcheck ignores the git
## repository)
if !PASS_ON_SILENT_RULES
AM_DISTCHECK_CONFIGURE_FLAGS += --disable-silent-rules
endif
