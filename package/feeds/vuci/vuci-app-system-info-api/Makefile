include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI API Support for System info

APP_DEPENDS:=+luci-bwc +rpcd-mod-mnfinfo

CUSTOM_INSTALL=1
include ../api.mk

define Package/$(PKG_NAME)/install
	$(call Package/$(PKG_NAME)/install/Default,$(1))
	$(INSTALL_BIN) ./files/sbin/cpu_usage_script.sh $(1)/sbin/cpu_usage_script.sh
endef

# call BuildPackage - OpenWrt buildroot signature
$(eval $(call BuildPackage,$(PKG_NAME)))
