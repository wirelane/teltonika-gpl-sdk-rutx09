#
# Copytight (C) 2024 Teltonika
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dot1x
PKG_RELEASE:=3
PKG_VERSION:=2024-09-27-dev
PKG_LICENSE:=Teltonika-closed

include $(INCLUDE_DIR)/package.mk
-include $(TOPDIR)/feeds/vuci/utils.mk
-include $(TOPDIR)/package/feeds/vuci/utils.mk

define Package/dot1x-client
	SECTION:=net
	CATEGORY:=Network
	TITLE:=802.1X Client
	DEPENDS:=+hostapd-common
endef




define Package/dot1x-client/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/uci-defaults/7.10/ $(1)/etc/init.d/ $(1)/etc/hotplug.d/iface/ $(1)/lib/config.d/ $(1)/etc/config/
	$(if $(CONFIG_DSA_SUPPORT), , $(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x-client.hotplug $(1)/etc/hotplug.d/iface/96-dot1x-client)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x_client.lua $(1)/usr/bin/dot1x_client
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x_client.init $(1)/etc/init.d/dot1x_client
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/defaults/99-dot1x-client-update $(1)/etc/uci-defaults/7.10/99_dot1x_client_update
	$(if $(CONFIG_AP_DEVICE),\
		$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x_ap.config $(1)/etc/config/dot1x,\
		$(if $(CONFIG_DSA_SUPPORT),
			$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/config.d/generate-dot1x-client-dsa $(1)/lib/config.d/798-generate-dot1x-client,\
			$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/config.d/generate-dot1x-client $(1)/lib/config.d/798-generate-dot1x-client
		)
	)
endef

$(eval $(call BuildPackage,dot1x-client))
