include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI UI Support for Cloud Solutions

CUSTOM_INSTALL=1
include ../app.mk

define Package/$(PKG_NAME)/install
	$(call Package/$(PKG_NAME)/install/Default,$(1))
	$(if $(CONFIG_PACKAGE_vuci-app-setup-wizard-ui),, \
        sed -i '/"system\/wizard\/step_rms": {/,/  }/d' "$(1)/usr/share/vuci/menu.d/cloud-solutions.json" ; \
        sed -i ':a;N;$!ba;s/,\n}/}/' "$(1)/usr/share/vuci/menu.d/cloud-solutions.json")
	$(if $(CONFIG_AP_DEVICE), \
		$(RM) $(1)/usr/share/vuci/menu.d/cloud-solutions.json, \
		$(RM) $(1)/usr/share/vuci/menu.d/cloud-solutions-ap.json)
endef

# call BuildPackage - OpenWrt buildroot signature
$(eval $(call BuildPackage,$(PKG_NAME)))