include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI UI Support for VRRP

ifeq (m, $(CONFIG_PACKAGE_vuci-app-vrrp-ui))
	APP_APP_NAME:=vrrpd
	APP_TLT_NAME:=VRRP
	APP_ROUTER:=$(TLT_PLATFORM_NAME)
endif

define Package/vuci-app-vrrp-ui/mdm9x07
  PKG_ROUTER:=TRB140 TRB143 TRB500
endef

include ../app.mk

# call BuildPackage - OpenWrt buildroot signature
