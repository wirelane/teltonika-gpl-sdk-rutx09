#
# Copyright (C) 2024 Teltonika-Networks
#

include $(TOPDIR)/rules.mk

PKG_NAME:=io_scheduler

PKG_SOURCE_VERSION:=1.2

PKG_LICENSE:=Teltonika-closed

include $(INCLUDE_DIR)/package.mk

define Package/io_scheduler
	SECTION:=base
	CATEGORY:=Base system
	TITLE:=Daemon providing I/O scheduling features
	DEPENDS:=+libuci +libubus +libubox +libtlt-logger +iomand
	USERID:=iosch:iosch
endef

define Package/io_scheduler/conffiles
/etc/config/io_scheduler
endef


define Package/io_scheduler/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/config $(1)/etc/init.d \
			$(1)/etc/uci-defaults/7.13 $(1)/usr/share/acl.d

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/scheduler $(1)/usr/bin/scheduler
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/ioman_scheduler.init \
			$(1)/etc/init.d/ioman_scheduler
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/files/io_scheduler.conf \
			$(1)/etc/config/io_scheduler
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/00_io_scheduler.sh \
			$(1)/etc/uci-defaults/7.13/00_io_scheduler
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/files/io_scheduler.json \
			$(1)/usr/share/acl.d/io_scheduler.json
endef

$(eval $(call BuildPackage,io_scheduler))
