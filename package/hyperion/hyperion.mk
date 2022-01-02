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

HYPERION_CONF_OPTS += -DBCM_INCLUDE_DIR="$(STAGING_DIR)/usr/" \
	-DBCM_LIBRARIES="$(STAGING_DIR)/usr/lib/" \
	-DDispmanx_LIBRARIES="bcm_host" \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_PREFIX_PATH=$(STAGING_DIR) \
	-DPLATFORM="rpi" \
	-Wno-dev \
	-DUSE_SYSTEM_PROTO_LIBS=ON \
	-DPROTOBUF_PROTOC_EXECUTABLE="$(HOST_DIR)/bin/protoc" \
	-DENABLE_OPENCV=OFF \
	-DENABLE_QT5=ON \
	-DUSE_SYSTEM_FLATBUFFERS_LIBS=ON \
	-B "$(@D)/output/" "$(@D)/"

HYPERION_DEPENDENCIES += libusb qt5base host-libusb rpi-firmware host-protobuf host-cmake

# rpi0, 1, 2 and 3
ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
HYPERION_DEPENDENCIES += rpi-userland
endif

define HYPERION_INSTALL_LIBS
	$(INSTALL) -D -m 0755 $(@D)/lib/*so $(TARGET_DIR)/usr/lib
endef
HYPERION_POST_INSTALL_TARGET_HOOKS += HYPERION_INSTALL_LIBS

$(eval $(cmake-package))
