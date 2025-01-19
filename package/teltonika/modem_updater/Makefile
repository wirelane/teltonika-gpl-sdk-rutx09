#
# Copyright (C) 2021 Teltonika
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/download.mk

PKG_NAME:=modem_updater
PKG_SOURCE_VERSION:=7.12

PKG_LICENSE:=Teltonika-closed

include $(INCLUDE_DIR)/package.mk

define Package/modem_updater
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Modem firmware update tool by Teltonika
	DEPENDS:=+libusb-1.0 +libstdcpp

	PKG_TLT_NAME:=Modem Updater
	PKG_ROUTER:=$(TLT_PLATFORM_NAME)
	PKG_HIDDEN:=1
endef

define Package/modem_updater/description
	Modem firmware update tool by Teltonika
endef


define Package/modem_updater/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(if $(findstring Quectel,$(CONFIG_DEVICE_MODEM_VENDORS)),
		$(INSTALL_BIN) $(PKG_BUILD_DIR)/quectel_flash/quectel_flash $(1)/usr/bin/quectel_flash
		$(if $(TLT_PLATFORM_TRB2)$(TLT_PLATFORM_TRB2M)$(TLT_PLATFORM_RUT361)$(TLT_PLATFORM_RUT36X)$(TLT_PLATFORM_TCR1),,
			$(INSTALL_BIN) $(PKG_BUILD_DIR)/QDLoader/quectel_loader $(1)/usr/bin/QDLoader
		),
	)
	$(if $(findstring Meiglink,$(CONFIG_DEVICE_MODEM_VENDORS)),
		$(INSTALL_BIN) $(PKG_BUILD_DIR)/Meig_Firehose/meig_firehose $(1)/usr/bin/meig_firehose
		$(if $(TLT_PLATFORM_RUT2M)$(TLT_PLATFORM_RUT206),,
			$(INSTALL_BIN) $(PKG_BUILD_DIR)/fbfdownloader/fbfdownloader $(1)/usr/bin/fbfdownloader
		),
	)
	$(if $(findstring Telit,$(CONFIG_DEVICE_MODEM_VENDORS)),
		$(INSTALL_BIN) $(PKG_BUILD_DIR)/telit_uxfp/uxfp/linux/uxfp $(1)/usr/bin/uxfp
	)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modem_updater.sh $(1)/usr/bin/modem_updater

endef

$(eval $(call BuildPackage,modem_updater))
