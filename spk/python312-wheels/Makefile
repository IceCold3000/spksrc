SPK_NAME = python312-wheels
SPK_VERS = 1.0
SPK_VERS_MAJOR_MINOR = $(word 1,$(subst ., ,$(SPK_VERS))).$(word 2,$(subst ., ,$(SPK_VERS)))
SPK_REV = 1
SPK_ICON = src/python3-pip.png

# Compiler must support std=c++11
UNSUPPORTED_ARCHS = $(OLD_PPC_ARCHS) $(ARMv5_ARCHS)

PYTHON_PACKAGE = python312
SPK_DEPENDS = "$(PYTHON_PACKAGE)"

MAINTAINER = SynoCommunity
DESCRIPTION =  Collection of programs for the Python 3.12 programming language.
DESCRIPTION_FRE = Collection of programs for the Python 3.12 programming language.
DESCRIPTION_SPN = Colección de programas para el lenguaje de programación Python 3.12.
STARTABLE = no
DISPLAY_NAME = Python 3.12 Wheels Collection
CHANGELOG = "1. Initial package"

HOMEPAGE = https://www.python.org
LICENSE  = PSF

# Enable debug_info symgols
#GCC_DEBUG_INFO := 1

WHEELS  = src/requirements-crossenv.txt
WHEELS += src/requirements-abi3.txt

include ../../mk/spksrc.common.mk

# [borgbackup]
# Use OpenSSL path as defined by either
# spksrc.wheel-env.mk or spksrc.python.mk
ENV += BORG_OPENSSL_PREFIX="$(OPENSSL_STAGING_PREFIX)"
ENV += BORG_LIBLZ4_PREFIX="$(STAGING_INSTALL_PREFIX)"
ENV += BORG_LIBZSTD_PREFIX="$(STAGING_INSTALL_PREFIX)"
ENV += BORG_LIBB2_PREFIX="$(STAGING_INSTALL_PREFIX)"
DEPENDS += cross/attr cross/acl cross/openssl3 cross/lz4 cross/zstd cross/libb2 cross/fuse
ifeq ($(call version_lt, $(TC_GCC), 5.0),1)
WHEELS_CFLAGS += [borgbackup] -std=c11
endif

# [cryptography]
# Use cross/cryptography to generate py36-abi3 limited API
# NOTE: It's not possible to build py36-abi3 limited API using pip due to PEP517
#       To generate py311-py311 regular build use src/requirements-crossenv.txt
DEPENDS += cross/cryptography

# [gevent]
DEPENDS += cross/libev cross/c-ares
ENV += GEVENTSETUP_EMBED_CARES=FALSE
ENV += GEVENTSETUP_EMBED_LIBEV=FALSE
ifeq ($(call version_lt, $(TC_GCC), 5.0),1)
WHEELS_CFLAGS += [gevent] -std=c11
endif

# [greenlet]
ifeq ($(call version_ge, $(TC_GCC), 5.0),1)
WHEELS += src/requirements-crossenv-greenlet-v3.txt
else
WHEELS += src/requirements-crossenv-greenlet-v3-gcc4.txt
WHEELS_CPPFLAGS += [greenlet] -std=c++11 -fpermissive
endif

# [llfuse]
ifeq ($(call version_lt, $(TC_GCC), 5.0),1)
WHEELS_CFLAGS += [llfuse] -std=c11
endif

# [lxml]
DEPENDS += cross/libxml2
DEPENDS += cross/libxslt
ifeq ($(call version_lt, $(TC_GCC), 5.0),1)
WHEELS_CFLAGS += [lxml] -std=c11
endif

# [msgpack]
ifeq ($(call version_lt, $(TC_GCC), 5.0),1)
WHEELS_CFLAGS += [msgpack] -std=c11
endif

# [mysqlclient]
DEPENDS += cross/mysql-connector-c
DEPENDS += cross/mariadb-connector-c
ENV += MYSQLCLIENT_CFLAGS="$(CFLAGS) -I$(STAGING_INSTALL_PREFIX)/include/mysql -I$(STAGING_INSTALL_PREFIX)/include/mariadb -I$(STAGING_INSTALL_PREFIX)/$(PYTHON_INC_DIR)"
ENV += MYSQLCLIENT_LDFLAGS="$(LDFLAGS)"

# [numpy] <= 1.21.6 (armv5)
# [numpy] <= 1.22.4 (armv7l)
# [numpy] <= 1.24.4 last working version with gcc-4.9
# These versions are now unsupported using py312
# [numpy] >= 1.25.0 requires c++17
ifeq ($(call version_gt, $(TC_GCC), 5.0),1)
WHEELS += src/requirements-crossenv-numpy.txt
endif

# [Pillow]
DEPENDS += cross/freetype cross/libjpeg cross/zlib
WHEELS_BUILD_ARGS += [Pillow]
WHEELS_BUILD_ARGS += build_ext
WHEELS_BUILD_ARGS += --disable-platform-guessing
WHEELS_BUILD_ARGS += --enable-freetype
WHEELS_BUILD_ARGS += --enable-jpeg
WHEELS_BUILD_ARGS += --enable-zlib

# [pycares]
DEPENDS += cross/c-ares
ENV += PYCARES_USE_SYSTEM_LIB=1

# [pycryptodome]
ifeq ($(call version_lt, $(TC_GCC), 5.0),1)
WHEELS_CFLAGS += [pycryptodome] -std=c11
endif

# [pycryptodomex]
ifeq ($(call version_lt, $(TC_GCC), 5.0),1)
WHEELS_CFLAGS += [pycryptodomex] -std=c11
endif

# [pycurl]
DEPENDS += cross/curl
ENV += PYCURL_CURL_CONFIG=$(STAGING_INSTALL_PREFIX)/bin/curl-config

# [pydantic_core]
# Requires path to maturin from crossenv
ifeq ($(call version_lt, $(TC_GCC), 5.0),1)
WHEELS_CFLAGS += [pydantic_core] -std=c11
endif

# [PyNaCl]
DEPENDS += cross/libsodium
ENV += SODIUM_INSTALL=system

# [PyYAML]
DEPENDS += cross/libyaml

# [ruamel.yaml.clib]
ifeq ($(call version_lt, $(TC_GCC), 5.0),1)
WHEELS_CFLAGS += [ruamel.yaml.clib] -std=c11
endif

# [rpds-py], [pydantic_core]
# Requires path to maturin from crossenv
ENV += PATH=$(WORK_DIR)/crossenv/build/bin:$(PATH)

include ../../mk/spksrc.python.mk
