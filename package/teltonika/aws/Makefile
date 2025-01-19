#
# Copyright (C) 2024 Teltonika
#

include $(TOPDIR)/rules.mk

PKG_NAME:=aws
PKG_VERSION:=2025-01-08
PKG_RELEASE:=1

PKG_SOURCE_VERSION:=1.3

PKG_LICENSE:=Teltonika-closed

include $(INCLUDE_DIR)/package.mk

define Package/aws
	SECTION:=base
	CATEGORY:=Base system
	DEPENDS:=+libubus +libuci +libaws-iot-device-sdk-embedded-C \
		 +libmosquitto +libtlt-logger +libubox +libblobmsg-json \
		 +libatomic +libapi
	TITLE:=AWS client
endef

define Package/aws/description
	AWS Cloud support.
endef

define Package/aws/conffiles
/etc/config/aws_jobs
endef


define Package/aws/install
	$(INSTALL_DIR) $(1)/usr/sbin $(1)/etc/init.d $(1)/etc/config

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/aws_jobs/aws_jobs $(1)/usr/sbin/aws_jobs
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/aws_jobs/files/aws.init $(1)/etc/init.d/aws
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/aws_jobs/files/aws.conf $(1)/etc/config/aws_jobs
endef

$(eval $(call BuildPackage,aws))
