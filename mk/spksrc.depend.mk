### Dependency rules
#   Build all dependencies listed in DEPENDS.
# Targets are executed in the following order:
#  depend_msg_target
#  pre_depend_target   (override with PRE_DEPEND_TARGET)
#  depend_target       (override with DEPEND_TARGET)
#  post_depend_target  (override with POST_DEPEND_TARGET)
# Variables:
#  DEPENDS             List of dependencies to go through
#  REQUIRE_KERNEL      If set, will compile kernel modules and allow
#                      use of KERNEL_DIR
#  REQUIRE_TOOLKIT     If set, will download and extract matching toolkit
#  BUILD_DEPENDS       List of dependencies to go through, PLIST is ignored

### For managing kernel modules dependent builds
include ../../mk/spksrc.kernel-modules.mk

DEPEND_COOKIE = $(WORK_DIR)/.$(COOKIE_PREFIX)depend_done

ifeq ($(strip $(PRE_DEPEND_TARGET)),)
PRE_DEPEND_TARGET = pre_depend_target
else
$(PRE_DEPEND_TARGET): depend_msg_target
endif
ifeq ($(strip $(DEPEND_TARGET)),)
DEPEND_TARGET = depend_target
else
$(DEPEND_TARGET): $(PRE_DEPEND_TARGET)
endif
ifeq ($(strip $(POST_DEPEND_TARGET)),)
POST_DEPEND_TARGET = post_depend_target
else
$(POST_DEPEND_TARGET): $(DEPEND_TARGET)
endif

ifeq ($(strip $(REQUIRE_TOOLKIT)),)
TOOLKIT_DEPEND = 
else
TOOLKIT_DEPEND = toolkit/syno-$(ARCH)-$(TCVERSION)
endif

depend_msg_target:
	@$(MSG) "Processing dependencies of $(NAME)"

pre_depend_target: depend_msg_target

depend_target: $(PRE_DEPEND_TARGET)
ifneq ($(strip $(REQUIRE_KERNEL_MODULE)),)
# As depend is also ran at toolchain-time, ensure to skip kernel-modules
ifeq ($(filter toolchain,$(shell basename $(abspath $(CURDIR)/../))),)
depend_target: kernel-modules
endif
endif
	@set -e; \
	for depend in $(BUILD_DEPENDS) $(TOOLKIT_DEPEND) $(DEPENDS); \
	do                          \
	  env $(ENV) $(MAKE) -C ../../$$depend ; \
	done
	
post_depend_target: $(DEPEND_TARGET)

	
ifeq ($(wildcard $(DEPEND_COOKIE)),)
depend: $(DEPEND_COOKIE)

$(DEPEND_COOKIE): $(POST_DEPEND_TARGET)
	$(create_target_dir)
	@touch -f $@
else
depend: ;
endif

