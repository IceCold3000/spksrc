PKG_NAME = LibRaw
PKG_VERS = 0.21.2
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://www.libraw.org/data
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = cross/lcms2 cross/jasper

# Toolchains lacking c++11 compiler ar not supported
UNSUPPORTED_ARCHS = $(ARMv5_ARCHS) $(OLD_PPC_ARCHS)

HOMEPAGE = https://www.libraw.org/
COMMENT  = The LibRaw library provides a simple and unified interface for extracting out of RAW files generated by digital photo cameras.
LICENSE  = GPLv1.2, CDDL 1.0

# REMARKS:
# we install the thread save version libraw_r only (see PLIST)

GNU_CONFIGURE = 1
CONFIGURE_ARGS  = --disable-static
CONFIGURE_ARGS += --enable-jasper
CONFIGURE_ARGS += ac_cv_lib_jasper_jas_init=yes
ADDITIONAL_CXXFLAGS = -O

include ../../mk/spksrc.cross-cc.mk
