#
# Copytight (C) 2024 Teltonika
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dot1x
PKG_RELEASE:=5
PKG_VERSION:=2025-01-04
PKG_LICENSE:=Teltonika-closed

include $(INCLUDE_DIR)/package.mk
-include $(TOPDIR)/feeds/vuci/utils.mk
-include $(TOPDIR)/package/feeds/vuci/utils.mk

define Package/dot1x-client
	SECTION:=net
	CATEGORY:=Network
	TITLE:=802.1X Client
	DEPENDS:=+wpad-openssl
	USERID:=dot1x_client:dot1x_client
endef




define Package/dot1x-client/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/uci-defaults/7.10/ $(1)/etc/init.d/ $(1)/etc/hotplug.d/iface/ $(1)/lib/config.d/ $(1)/etc/config/ $(1)/usr/share/acl.d
	$(if $(CONFIG_DSA_SUPPORT), , $(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x-client.hotplug $(1)/etc/hotplug.d/iface/96-dot1x-client)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x_client.lua $(1)/usr/bin/dot1x_client
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x_client.init $(1)/etc/init.d/dot1x_client
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/defaults/99-dot1x-client-update $(1)/etc/uci-defaults/7.10/99_dot1x_client_update
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/files/dot1x_client.json $(1)/usr/share/acl.d/dot1x_client.json
	$(if $(CONFIG_AP_DEVICE),\
		$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x_ap.config $(1)/etc/config/dot1x,\
		$(if $(CONFIG_DSA_SUPPORT),
			$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/config.d/generate-dot1x-client-dsa $(1)/lib/config.d/798-generate-dot1x-client,\
			$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/config.d/generate-dot1x-client $(1)/lib/config.d/798-generate-dot1x-client
		)
	)
endef

$(eval $(call BuildPackage,dot1x-client))
