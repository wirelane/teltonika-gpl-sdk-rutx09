#
# Copytight (C) 2024 Teltonika
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dot1x
PKG_RELEASE:=1
PKG_VERSION:=2024-09-27
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
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/uci-defaults/ $(1)/etc/init.d/ $(1)/etc/hotplug.d/iface/
	$(if $(CONFIG_DSA_SUPPORT), , $(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x-client.hotplug $(1)/etc/hotplug.d/iface/96-dot1x-client)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x_client.lua $(1)/usr/bin/dot1x_client
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dot1x_client.init $(1)/etc/init.d/dot1x_client
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/defaults/dot1x_client $(1)/etc/uci-defaults/99_dot1x_client
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/defaults/99-dot1x-client-update $(1)/etc/uci-defaults/99_dot1x_client_update
endef

$(eval $(call BuildPackage,dot1x-client))
