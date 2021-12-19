PKG_NAME = bind
PKG_VERS = 9.16.23
PKG_EXT = tar.xz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://downloads.isc.org/isc/bind9/$(PKG_VERS)
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = cross/libuv cross/openssl cross/libcap cross/readline

# by cross/libuv
UNSUPPORTED_ARCHS = $(OLD_PPC_ARCHS)

HOMEPAGE = https://www.isc.org/
COMMENT  = BIND (Berkeley Internet Name Domain) is a complete, highly portable implementation of the DNS (Domain Name System) protocol.
LICENSE  = MPL 2.0

GNU_CONFIGURE = 1
CONFIGURE_ARGS  = --without-python
# needed for cross compile:
CONFIGURE_ARGS += BUILD_CC="$(CC)"
CONFIGURE_ARGS += BUILD_CFLAGS="$(CFLAGS)"
CONFIGURE_ARGS += BUILD_CPPFLAGS="$(CPPFLAGS)"
CONFIGURE_ARGS += BUILD_LDFLAGS="$(LDFLAGS)"
CONFIGURE_ARGS += BUILD_LIBS="$(LIBS)"

PRE_COMPILE_TARGET = bind_pre_compile

include ../../mk/spksrc.cross-cc.mk

.PHONY: bind_pre_compile
bind_pre_compile:
	@$(MSG) Build gen tool for host
	# compile gen tool with host compiler to run in build environment
	cd $(WORK_DIR)/$(PKG_DIR)/lib/dns; gcc -m32 -I../../lib/isc/include -o gen ./gen.c