################################################################################
#
# Hyperion
#
################################################################################

HYPERION_SITE = https://github.com/hyperion-project/hyperion.ng.git
HYPERION_VERSION = 2.0.12
HYPERION_LICENSE = MIT
HYPERION_SITE_METHOD = git
HYPERION_GIT_SUBMODULES = YES

HYPERION_CONF_OPTS += -DCMAKE_PREFIX_PATH=$(STAGING_DIR) \
	-Wno-dev \
	-DUSE_SYSTEM_PROTO_LIBS=ON \
	-DUSE_SYSTEM_FLATBUFFERS_LIBS=ON \
	-DBUILD_SHARED_LIBS=OFF \
	-DENABLE_DISPMANX=OFF \
	-DENABLE_DEPLOY_DEPENDENCIES=OFF \
	"$(@D)/"

HYPERION_DEPENDENCIES += libusb host-libusb host-protobuf host-cmake qt5base qt5serialport flatbuffers protobuf libcec avahi jpeg-turbo

# rpi0, 1, 2 and 3
ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
HYPERION_DEPENDENCIES += rpi-userland
endif

define HYPERION_INSTALL_LIBS
	$(INSTALL) -D -m 0755 $(@D)/lib/*a $(TARGET_DIR)/usr/lib
endef
HYPERION_POST_INSTALL_TARGET_HOOKS += HYPERION_INSTALL_LIBS

$(eval $(cmake-package))
